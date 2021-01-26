# frozen_string_literal: true
module GraphQL
  module Define
    # Some conveniences for definining return & argument types.
    #
    # Passed into initialization blocks, eg {ObjectType#initialize}, {Field#initialize}
    class TypeDefiner
      include Singleton
      # rubocop:disable Naming/MethodName
      def Int;      GraphQL::Deprecation_INT_TYPE;      end
      def String;   GraphQL::Deprecation_STRING_TYPE;   end
      def Float;    GraphQL::Deprecation_FLOAT_TYPE;    end
      def Boolean;  GraphQL::Deprecation_BOOLEAN_TYPE;  end
      def ID;       GraphQL::Deprecation_ID_TYPE;       end
      # rubocop:enable Naming/MethodName

      # Make a {ListType} which wraps the input type
      #
      # @example making a list type
      #   list_of_strings = types[types.String]
      #   list_of_strings.inspect
      #   # => "[String]"
      #
      # @param type [Type] A type to be wrapped in a ListType
      # @return [GraphQL::ListType] A ListType wrapping `type`
      def [](type)
        type.to_list_type
      end
    end
  end
end
