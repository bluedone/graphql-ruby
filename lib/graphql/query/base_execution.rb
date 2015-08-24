require 'graphql/query/base_execution/selected_object_resolution'
require 'graphql/query/base_execution/value_resolution'

module GraphQL
  class Query
    class BaseExecution

      def field_resolution
        get_class :FieldResolution
      end

      def fragment_spread_resolution
        get_class :FragmentSpreadResolution
      end

      def inline_fragment_resolution
        get_class :InlineFragmentResolution
      end

      def operation_resolution
        get_class :OperationResolution
      end

      def selection_resolution
        get_class :SelectionResolution
      end

      # ParallelExecution overrides this to provide
      # real async behavior
      def async(&block)
        block.call
      end

      private

      def get_class(class_name)
        self.class.const_get(class_name)
      end
    end
  end
end
