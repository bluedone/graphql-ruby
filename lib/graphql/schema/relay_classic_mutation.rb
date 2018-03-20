# frozen_string_literal: true

module GraphQL
  class Schema
    class RelayClassicMutation < GraphQL::Schema::Mutation
      class << self
        # The base class for generated input object types
        def input_object_class(new_class = nil)
          if new_class
            @input_object_class = new_class
          end
          @input_object_class || (defined?(super) ? super : GraphQL::Schema::InputObject)
        end

        def input_type(new_input_type = nil)
          if new_input_type
            @input_type = new_input_type
          end
          @input_type ||= generate_input_type
        end

        private

        # Modify the payload type to include a `clientMutationId` field
        def generate_payload_type
          type_class = super
          type_class.field(:client_mutation_id, String, "A unique identifier for the client performing the mutation.", null: true)
          type_class
        end

        def generate_field
          field_instance = super
          field_instance.own_arguments.clear
          field_instance.argument(:input, generate_input_type, required: true)
          field_instance
        end

        # Generate the input type for the `input:` argument
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

        def resolve_field(obj, args, ctx)
          mutation = self.new(object: obj, arguments: args, context: ctx.query.context)
          kwargs = args.to_kwargs
          # This is handled by Relay::Mutation::Resolve, a bit hacky, but here we are.
          kwargs.delete(:client_mutation_id)
          mutation.resolve(**kwargs)
        end
      end
    end
  end
end
