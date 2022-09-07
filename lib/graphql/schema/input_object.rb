# frozen_string_literal: true
module GraphQL
  class Schema
    class InputObject < GraphQL::Schema::Member
      extend Forwardable
      extend GraphQL::Schema::Member::HasArguments
      extend GraphQL::Schema::Member::HasArguments::ArgumentObjectLoader
      extend GraphQL::Schema::Member::ValidatesInput
      extend GraphQL::Schema::Member::HasValidators

      include GraphQL::Dig

      # @return [GraphQL::Query::Context] The context for this query
      attr_reader :context
      # @return [GraphQL::Execution::Interpereter::Arguments] The underlying arguments instance
      attr_reader :arguments

      # Ruby-like hash behaviors, read-only
      def_delegators :@ruby_style_hash, :keys, :values, :each, :map, :any?, :empty?

      def initialize(arguments, ruby_kwargs:, context:, defaults_used:)
        @context = context
        @ruby_style_hash = ruby_kwargs
        @arguments = arguments
        # Apply prepares, not great to have it duplicated here.
        self.class.arguments(context).each_value do |arg_defn|
          ruby_kwargs_key = arg_defn.keyword
          if @ruby_style_hash.key?(ruby_kwargs_key)
            # Weirdly, procs are applied during coercion, but not methods.
            # Probably because these methods require a `self`.
            if arg_defn.prepare.is_a?(Symbol) || context.nil?
              prepared_value = arg_defn.prepare_value(self, @ruby_style_hash[ruby_kwargs_key])
              overwrite_argument(ruby_kwargs_key, prepared_value)
            end
          end
        end
      end

      def to_h
        unwrap_value(@ruby_style_hash)
      end

      def to_hash
        to_h
      end

      def prepare
        if @context
          object = @context[:current_object]
          # Pass this object's class with `as` so that messages are rendered correctly from inherited validators
          Schema::Validator.validate!(self.class.validators, object, @context, @ruby_style_hash, as: self.class)
          self
        else
          self
        end
      end

      def self.authorized?(obj, value, ctx)
        # Authorize each argument (but this doesn't apply if `prepare` is implemented):
        if value.respond_to?(:key?)
          arguments(ctx).each do |_name, input_obj_arg|
            if value.key?(input_obj_arg.keyword) &&
              !input_obj_arg.authorized?(obj, value[input_obj_arg.keyword], ctx)
              return false
            end
          end
        end
        # It didn't early-return false:
        true
      end

      def self.one_of
        if !@one_of
          if (required_arg = all_argument_definitions.find { |arg| arg.type.non_null? })
            raise ArgumentError, "`one_of` may not be used with required arguments -- add `required: false` to `argument #{required_arg.keyword.inspect}` to use `one_of`"
          end
          @one_of = true
          directive(GraphQL::Schema::Directive::OneOf)
        end
      end

      def self.one_of?
        directives.any? { |d| d.is_a?(GraphQL::Schema::Directive::OneOf) }
      end

      def unwrap_value(value)
        case value
        when Array
          value.map { |item| unwrap_value(item) }
        when Hash
          value.reduce({}) do |h, (key, value)|
            h.merge!(key => unwrap_value(value))
          end
        when InputObject
          value.to_h
        else
          value
        end
      end

      # Lookup a key on this object, it accepts new-style underscored symbols
      # Or old-style camelized identifiers.
      # @param key [Symbol, String]
      def [](key)
        if @ruby_style_hash.key?(key)
          @ruby_style_hash[key]
        elsif @arguments
          @arguments[key]
        else
          nil
        end
      end

      def key?(key)
        @ruby_style_hash.key?(key) || (@arguments && @arguments.key?(key)) || false
      end

      # A copy of the Ruby-style hash
      def to_kwargs
        @ruby_style_hash.dup
      end

      class << self
        def argument(*args, **kwargs, &block)
          argument_defn = super(*args, **kwargs, &block)
          if one_of? && argument_defn.type.non_null?
            raise ArgumentError, "`one_of` may not be used with required arguments -- add `required: false` to `argument #{argument_defn.keyword.inspect}` to use `one_of`"
          end
          # Add a method access
          method_name = argument_defn.keyword
          class_eval <<-RUBY, __FILE__, __LINE__
            def #{method_name}
              self[#{method_name.inspect}]
            end
          RUBY
          argument_defn
        end

        def kind
          GraphQL::TypeKinds::INPUT_OBJECT
        end

        # @api private
        INVALID_OBJECT_MESSAGE = "Expected %{object} to be a key-value object responding to `to_h` or `to_unsafe_h`."

        def validate_non_null_input(input, ctx)
          warden = ctx.warden

          if input.is_a?(Array)
            return GraphQL::Query::InputValidationResult.from_problem(INVALID_OBJECT_MESSAGE % { object: JSON.generate(input, quirks_mode: true) })
          end

          if !(input.respond_to?(:to_h) || input.respond_to?(:to_unsafe_h))
            # We're not sure it'll act like a hash, so reject it:
            return GraphQL::Query::InputValidationResult.from_problem(INVALID_OBJECT_MESSAGE % { object: JSON.generate(input, quirks_mode: true) })
          end

          # Inject missing required arguments
          missing_required_inputs = self.arguments(ctx).reduce({}) do |m, (argument_name, argument)|
            if !input.key?(argument_name) && argument.type.non_null? && warden.get_argument(self, argument_name)
              m[argument_name] = nil
            end

            m
          end

          result = nil
          [input, missing_required_inputs].each do |args_to_validate|
            args_to_validate.each do |argument_name, value|
              argument = warden.get_argument(self, argument_name)
              # Items in the input that are unexpected
              if argument.nil?
                result ||= Query::InputValidationResult.new
                result.add_problem("Field is not defined on #{self.graphql_name}", [argument_name])
              else
                # Items in the input that are expected, but have invalid values
                argument_result = argument.type.validate_input(value, ctx)
                result ||= Query::InputValidationResult.new
                if !argument_result.valid?
                  result.merge_result!(argument_name, argument_result)
                end
              end
            end
          end

          if one_of?
            if input.size == 1
              input.each do |name, value|
                if value.nil?
                  result ||= Query::InputValidationResult.new
                  result.add_problem("'#{graphql_name}' requires exactly one argument, but '#{name}' was `null`.")
                end
              end
            else
              result ||= Query::InputValidationResult.new
              result.add_problem("'#{graphql_name}' requires exactly one argument, but #{input.size} were provided.")
            end
          end

          result
        end

        def coerce_input(value, ctx)
          if value.nil?
            return nil
          end

          arguments = coerce_arguments(nil, value, ctx)

          ctx.schema.after_lazy(arguments) do |resolved_arguments|
            if resolved_arguments.is_a?(GraphQL::Error)
              raise resolved_arguments
            else
              input_obj_instance = self.new(resolved_arguments, ruby_kwargs: resolved_arguments.keyword_arguments, context: ctx, defaults_used: nil)
              input_obj_instance.prepare
            end
          end
        end

        # It's funny to think of a _result_ of an input object.
        # This is used for rendering the default value in introspection responses.
        def coerce_result(value, ctx)
          # Allow the application to provide values as :snake_symbols, and convert them to the camelStrings
          value = value.reduce({}) { |memo, (k, v)| memo[Member::BuildType.camelize(k.to_s)] = v; memo }

          result = {}

          arguments(ctx).each do |input_key, input_field_defn|
            input_value = value[input_key]
            if value.key?(input_key)
              result[input_key] = if input_value.nil?
                nil
              else
                input_field_defn.type.coerce_result(input_value, ctx)
              end
            end
          end

          result
        end
      end

      private

      def overwrite_argument(key, value)
        # Argument keywords come in frozen from the interpreter, dup them before modifying them.
        if @ruby_style_hash.frozen?
          @ruby_style_hash = @ruby_style_hash.dup
        end
        @ruby_style_hash[key] = value
      end
    end
  end
end
