module GraphQL
  class Schema
    class Validator
      class NumericalityValidator < Validator
        def initialize(argument,
            greater_than: nil, greater_than_or_equal_to: nil,
            less_than: nil, less_than_or_equal_to: nil,
            equal_to: nil, other_than: nil,
            odd: nil, even: nil,
            message: "%{argument} must be %{comparison} %{target}",
            **default_options
          )

          @greater_than = greater_than
          @greater_than_or_equal_to = greater_than_or_equal_to
          @less_than = less_than
          @less_than_or_equal_to = less_than_or_equal_to
          @equal_to = equal_to
          @other_than = other_than
          @odd = odd
          @even = even
          @message = message
          super(argument, **default_options)
        end

        def validate(object, context, value)
          if @greater_than && value <= @greater_than
            @message % { argument: @argument.graphql_name, comparison: "greater than", target: @greater_than }
          elsif @greater_than_or_equal_to && value < @greater_than_or_equal_to
            @message % { argument: @argument.graphql_name, comparison: "greater than or equal to", target: @greater_than_or_equal_to }
          elsif @less_than && value >= @less_than
            @message % { argument: @argument.graphql_name, comparison: "less than", target: @less_than }
          elsif @less_than_or_equal_to && value > @less_than_or_equal_to
            @message % { argument: @argument.graphql_name, comparison: "less than or equal to", target: @less_than_or_equal_to }
          elsif @equal_to && value != @equal_to
            @message % { argument: @argument.graphql_name, comparison: "equal to", target: @equal_to }
          elsif @other_than && value == @other_than
            @message % { argument: @argument.graphql_name, comparison: "something other than", target: @other_than }
          elsif @even && !value.even?
            (@message % { argument: @argument.graphql_name, comparison: "even", target: "" }).strip
          elsif @odd && !value.odd?
            (@message % { argument: @argument.graphql_name, comparison: "odd", target: "" }).strip
          end
        end
      end
    end
  end
end
