require "parslet"
require "active_support/core_ext/string/inflections"
require "active_support/core_ext/object/blank"

module GraphQL
  autoload(:CollectionEdge,   "graphql/collection_edge")
  autoload(:Parser,           "graphql/parser")
  autoload(:Query,            "graphql/query")
  autoload(:Node,             "graphql/node")
  autoload(:Transform,        "graphql/transform")
  autoload(:VERSION,          "graphql/version")

  module Syntax
    autoload(:Call,       "graphql/syntax/call")
    autoload(:Edge,       "graphql/syntax/edge")
    autoload(:Field,      "graphql/syntax/field")
    autoload(:Node,       "graphql/syntax/node")
  end

  TYPE_ALIASES = {}
  PARSER = Parser.new
  TRANSFORM = Transform.new

  class FieldNotDefinedError < RuntimeError; end
  class NodeNotDefinedError < RuntimeError
    def initialize(node_name)
      super("#{node_name} was requested but was not found")
    end
  end
end