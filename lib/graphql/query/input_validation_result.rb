# frozen_string_literal: true
module GraphQL
  class Query
    class InputValidationResult
      attr_accessor :problems

      def initialize(valid: nil, problems: nil)
        @valid = valid
        @problems = problems
      end

      def valid?
        if @valid.nil?
          @problems.nil?
        else
          @valid
        end
      end

      def add_problem(explanation, path = nil, extensions: nil, message: nil)
        @problems ||= []
        problem = { "path" => path || [], "explanation" => explanation }
        if extensions
          problem["extensions"] = extensions
        end
        if message
          problem["message"] = message
        end
        @problems.push(problem)
      end

      def merge_result!(path, inner_result)
        return if inner_result.valid?

        if inner_result.problems
          inner_result.problems.each do |p|
            item_path = [path, *p["path"]]
            add_problem(p["explanation"], item_path, message: p["message"], extensions: p["extensions"])
          end
        end
        # It could have been explicitly set on inner_result (if it had no problems)
        @valid = false
      end
    end
  end
end
