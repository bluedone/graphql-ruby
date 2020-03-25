# frozen_string_literal: true

require "graphql/query/null_context"

module GraphQL
  class Schema
    class Object < GraphQL::Schema::Member
      extend GraphQL::Schema::Member::AcceptsDefinition
      extend GraphQL::Schema::Member::HasFields

      # @return [Object] the application object this type is wrapping
      attr_reader :object

      # @return [GraphQL::Query::Context] the context instance for this query
      attr_reader :context

      class << self
        # This is protected so that we can be sure callers use the public method, {.authorized_new}
        # @see authorized_new to make instances
        protected :new

        # Make a new instance of this type _if_ the auth check passes,
        # otherwise, raise an error.
        #
        # Probably only the framework should call this method.
        #
        # This might return a {GraphQL::Execution::Lazy} if the user-provided `.authorized?`
        # hook returns some lazy value (like a Promise).
        #
        # The reason that the auth check is in this wrapper method instead of {.new} is because
        # of how it might return a Promise. It would be weird if `.new` returned a promise;
        # It would be a headache to try to maintain Promise-y state inside a {Schema::Object}
        # instance. So, hopefully this wrapper method will do the job.
        #
        # @param object [Object] The thing wrapped by this object
        # @param context [GraphQL::Query::Context]
        # @return [GraphQL::Schema::Object, GraphQL::Execution::Lazy]
        # @raise [GraphQL::UnauthorizedError] if the user-provided hook returns `false`
        def authorized_new(object, context)
          auth_val = context.query.with_error_handling do
            begin
              authorized?(object, context)
            rescue GraphQL::UnauthorizedError => err
              context.schema.unauthorized_object(err)
            end
          end

          context.schema.after_lazy(auth_val) do |is_authorized|
            if is_authorized
              self.new(object, context)
            else
              # It failed the authorization check, so go to the schema's authorized object hook
              err = GraphQL::UnauthorizedError.new(object: object, type: self, context: context)
              # If a new value was returned, wrap that instead of the original value
              begin
                new_obj = context.schema.unauthorized_object(err)
                if new_obj
                  self.new(new_obj, context)
                else
                  nil
                end
              end
            end
          end
        end
      end

      def initialize(object, context)
        @object = object
        @context = context
      end

      class << self
        def implements(*new_interfaces, **options)
          new_memberships = []
          new_interfaces.each do |int|
            if int.is_a?(Module)
              unless int.include?(GraphQL::Schema::Interface)
                raise "#{int} cannot be implemented since it's not a GraphQL Interface. Use `include` for plain Ruby modules."
              end

              new_memberships << int.type_membership_class.new(int, self, options)

              # Include the methods here,
              # `.fields` will use the inheritance chain
              # to find inherited fields
              include(int)
            elsif int.is_a?(String) || int.is_a?(GraphQL::Schema::LateBoundType)
              new_memberships << int
            else
              raise ArgumentError, "Unexpected interface definition (expected module): #{int} (#{int.class})"
            end
          end

          # Remove any interfaces which are being replaced (late-bound types are updated in place this way)
          interface_type_memberships.reject! { |existing_i_m|
            new_memberships.any? { |new_i_m|
              new_name = new_i_m.is_a?(String) ? new_i_m : new_i_m.abstract_type.graphql_name
              old_name = if existing_i_m.is_a?(String)
                existing_i_m
              elsif existing_i_m.is_a?(GraphQL::Schema::LateBoundType)
                existing_i_m.graphql_name
              else
                existing_i_m.abstract_type.graphql_name
              end
              new_name == old_name
            }
          }
          interface_type_memberships.concat(new_memberships)
        end

        def interface_type_memberships
          @interface_type_memberships ||= []
        end

        # param context [Query::Context, nil] If `nil` is given, skip filtering.
        def interfaces(context = GraphQL::Query::NullContext)
          if context.nil?
            visible_interfaces = interface_type_memberships
              .select { |tm| tm.is_a?(Schema::TypeMembership) } # exclude strings and late-bound types
              .map(&:abstract_type)
          else
            visible_interfaces = []
            interface_type_memberships.each do |type_membership|
              vis = type_membership.visible?(context)
              if vis
                visible_interfaces << type_membership.abstract_type
              end
            end
          end
          visible_interfaces + (superclass <= GraphQL::Schema::Object ? superclass.interfaces(context) : [])
        end

        # Include legacy-style interfaces, too
        def fields
          all_fields = super
          interfaces(nil).each do |int|
            if int.is_a?(GraphQL::InterfaceType)
              int_f = {}
              int.fields.each do |name, legacy_field|
                int_f[name] = field_class.from_options(name, field: legacy_field)
              end
              all_fields = int_f.merge(all_fields)
            end
          end
          all_fields
        end

        # @return [GraphQL::ObjectType]
        def to_graphql
          obj_type = GraphQL::ObjectType.new
          obj_type.name = graphql_name
          obj_type.description = description
          obj_type.interface_type_memberships = interface_type_memberships
          obj_type.introspection = introspection
          obj_type.mutation = mutation
          obj_type.ast_node = ast_node
          fields.each do |field_name, field_inst|
            field_defn = field_inst.to_graphql
            obj_type.fields[field_defn.name] = field_defn
          end

          obj_type.metadata[:type_class] = self

          obj_type
        end

        def kind
          GraphQL::TypeKinds::OBJECT
        end
      end
    end
  end
end
