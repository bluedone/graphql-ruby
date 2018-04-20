# frozen_string_literal: true

module GraphQL
  class Schema
    # Mutations that extend this base class get some conventions added for free:
    #
    # - An argument called `clientMutationId` is _always_ added, but it's not passed
    #   to the resolve method. The value is re-inserted to the response. (It's for
    #   client libraries to manage optimistic updates.)
    # - The returned object type always has a field called `clientMutationId` to support that.
    # - The mutation accepts one argument called `input`, `argument`s defined in the mutation
    #   class are added to that input object, which is generated by the mutation.
    #
    # These conventions were first specified by Relay Classic, but they come in handy:
    #
    # - `clientMutationId` supports optimistic updates and cache rollbacks on the client
    # - using a single `input:` argument makes it easy to post whole JSON objects to the mutation
    #   using one GraphQL variable (`$input`) instead of making a separate variable for each argument.
    #
    # @see {GraphQL::Schema::Mutation} for an example, it's basically the same.
    #
    class RelayClassicMutation < GraphQL::Schema::Mutation
      # The payload should always include this field
      field(:client_mutation_id, String, "A unique identifier for the client performing the mutation.", null: true)

      class << self
        def inherited(base)
          base.null(true)
          super
        end

        # The base class for generated input object types
        # @param new_class [Class] The base class to use for generating input object definitions
        # @return [Class] The base class for this mutation's generated input object (default is {GraphQL::Schema::InputObject})
        def input_object_class(new_class = nil)
          if new_class
            @input_object_class = new_class
          end
          @input_object_class || (superclass.respond_to?(:input_object_class) ? superclass.input_object_class : GraphQL::Schema::InputObject)
        end

        # @param new_input_type [Class, nil] If provided, it configures this mutation to accept `new_input_type` instead of generating an input type
        # @return [Class] The generated {Schema::InputObject} class for this mutation's `input`
        def input_type(new_input_type = nil)
          if new_input_type
            @input_type = new_input_type
          end
          @input_type ||= generate_input_type
        end

        private

        # Extend {Schema::Mutation.generate_field} to add the `input` argument
        def generate_field
          field_instance = super
          field_instance.own_arguments.clear
          field_instance.argument(:input, input_type, required: true)
          field_instance
        end

        # Generate the input type for the `input:` argument
        # To customize how input objects are generated, override this method
        # @return [Class] a subclass of {.input_object_class}
        def generate_input_type
          mutation_args = arguments
          mutation_name = graphql_name
          mutation_class = self
          Class.new(input_object_class) do
            graphql_name("#{mutation_name}Input")
            description("Autogenerated input type of #{mutation_name}")
            mutation(mutation_class)
            own_arguments.merge!(mutation_args)
            argument :client_mutation_id, String, "A unique identifier for the client performing the mutation.", required: false
          end
        end

        # Override {GraphQL::Schema::Mutation.resolve_field} to
        # delete `client_mutation_id` from the kwargs.
        def resolve_field(obj, args, ctx)
          mutation = self.new(object: obj, arguments: args, context: ctx.query.context)
          kwargs = args.to_kwargs
          # This is handled by Relay::Mutation::Resolve, a bit hacky, but here we are.
          kwargs.delete(:client_mutation_id)
          extras.each { |e| kwargs[e] = ctx.public_send(e) }
          mutation.resolve(**kwargs)
        end
      end
    end
  end
end
