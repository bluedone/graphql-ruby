# frozen_string_literal: true

module GraphQL
  module Types
    module Relay
      module HasNodeField
        def self.included(child_class)
          child_class.field(**field_options, &field_block)
        end

        class << self
          def field_options
            {
              name: "node",
              owner: nil,
              type: GraphQL::Types::Relay::Node,
              null: true,
              description: "Fetches an object given its ID.",
              relay_node_field: true,
            }
          end

          def field_block
            -> {
              argument :id, "ID!", required: true,
                description: "ID of the object."

              def resolve(obj, args, ctx)
                ctx.schema.object_from_id(args[:id], ctx)
              end

              def resolve_field(obj, args, ctx)
                resolve(obj, args, ctx)
              end
            }
          end
        end
      end
    end
  end
end
