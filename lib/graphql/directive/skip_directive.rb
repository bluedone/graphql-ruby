GraphQL::Directive::SkipDirective = GraphQL::Directive.define do
  name "skip"
  description "Ignore this part of the query if `if` is true"
  on([GraphQL::Directive::ON_FIELD, GraphQL::Directive::ON_FRAGMENT])

  argument :if, !GraphQL::BOOLEAN_TYPE

  resolve -> (arguments, proc) {
    if !arguments["if"]
      proc.call
    else
      nil
    end
  }
end
