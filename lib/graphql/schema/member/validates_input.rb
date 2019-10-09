# frozen_string_literal: true

module GraphQL
  class Schema
    class Member
      module ValidatesInput
        def valid_input?(val, ctx)
          validate_input(val, ctx).valid?
        end

        def validate_input(val, ctx)
          if val.nil?
            GraphQL::Query::InputValidationResult.new
          else
            validate_non_null_input(val, ctx)
          end
        end

        def coerce_input(val, ctx)
          if val.nil?
            nil
          else
            coerce_non_null_input(val, ctx)
          end
        end

        def valid_isolated_input?(v)
          valid_input?(v, GraphQL::Query::NullContext)
        end

        def coerce_isolated_input(v)
          coerce_input(v, GraphQL::Query::NullContext)
        end

        def coerce_isolated_result(v)
          coerce_result(v, GraphQL::Query::NullContext)
        end
      end
    end
  end
end
