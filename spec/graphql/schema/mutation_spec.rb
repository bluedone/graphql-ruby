# frozen_string_literal: true
require "spec_helper"

# Make sure that `!` has no effect
using GraphQL::DeprecatedDSL

describe GraphQL::Schema::Mutation do
  let(:mutation) { Jazz::AddInstrument }
  after do
    Jazz::Models.reset
  end

  it "Doesn't override !" do
    assert_equal false, !mutation
  end

  describe "definition" do
    it "passes along description" do
      assert_equal "Register a new musical instrument in the database", mutation.graphql_field.description
      assert_equal "Autogenerated return type of AddInstrument", mutation.payload_type.description
    end
  end

  describe "argument prepare" do
    it "calls methods on the mutation, uses `as:`" do
      query_str = 'mutation { prepareInput(input: 4) }'
      res = Jazz::Schema.execute(query_str)
      assert_equal 16, res["data"]["prepareInput"], "It's squared by the prepare method"
    end
  end

  describe ".field" do
    it "returns a GraphQL::Field instance, for backwards compat" do
      field = mutation.field
      assert_instance_of GraphQL::Field, field
      assert_equal "addInstrument", field.name
    end

    it "has a reference to the mutation" do
      f = mutation.field
      assert_equal mutation, f.mutation

      # Make sure it's also present in the schema
      f2 = Jazz::Schema.find("Mutation.addInstrument")
      assert_equal mutation, f2.mutation
    end
  end

  describe ".payload_type" do
    it "has a reference to the mutation" do
      assert_equal mutation, mutation.payload_type.mutation
    end
  end

  describe ".object_class" do
    it "can override & inherit the parent class" do
      obj_class = Class.new(GraphQL::Schema::Object)
      mutation_class = Class.new(GraphQL::Schema::Mutation) do
        object_class(obj_class)
      end
      mutation_subclass = Class.new(mutation_class)

      assert_equal(GraphQL::Schema::Object, GraphQL::Schema::Mutation.object_class)
      assert_equal(obj_class, mutation_class.object_class)
      assert_equal(obj_class, mutation_subclass.object_class)    end
  end

  describe ".argument_class" do
    it "can override & inherit the parent class" do
      arg_class = Class.new(GraphQL::Schema::Argument)
      mutation_class = Class.new(GraphQL::Schema::Mutation) do
        argument_class(arg_class)
      end

      mutation_subclass = Class.new(mutation_class)

      assert_equal(GraphQL::Schema::Argument, GraphQL::Schema::Mutation.argument_class)
      assert_equal(arg_class, mutation_class.argument_class)
      assert_equal(arg_class, mutation_subclass.argument_class)
    end
  end

  describe "evaluation" do
    it "runs mutations" do
      query_str = <<-GRAPHQL
      mutation {
        addInstrument(name: "Trombone", family: BRASS) {
          instrument {
            name
            family
          }
          entries {
            name
          }
          ee
        }
      }
      GRAPHQL

      response = Jazz::Schema.execute(query_str)
      assert_equal "Trombone", response["data"]["addInstrument"]["instrument"]["name"]
      assert_equal "BRASS", response["data"]["addInstrument"]["instrument"]["family"]
      assert_equal "GraphQL::Query::Context::ExecutionErrors", response["data"]["addInstrument"]["ee"]
      assert_equal 7, response["data"]["addInstrument"]["entries"].size
    end
  end

  describe ".null" do
    it "overrides whether or not the field can be null" do
      non_nullable_mutation_class = Class.new(GraphQL::Schema::Mutation) do
        graphql_name "Thing1"
        null(false)
      end

      nullable_mutation_class = Class.new(GraphQL::Schema::Mutation) do
        graphql_name "Thing2"
        null(true)
      end

      default_mutation_class = Class.new(GraphQL::Schema::Mutation) do
        graphql_name "Thing3"
      end

      assert default_mutation_class.graphql_field.instance_variable_get("@return_type_null")
      assert nullable_mutation_class.graphql_field.instance_variable_get("@return_type_null")
      refute non_nullable_mutation_class.graphql_field.instance_variable_get("@return_type_null")
    end

    it "should inherit and override in subclasses" do
      base_mutation = Class.new(GraphQL::Schema::Mutation) do
        null(false)
      end

      inheriting_mutation = Class.new(base_mutation) do
        graphql_name "Thing"
      end

      override_mutation = Class.new(base_mutation) do
        graphql_name "Thing2"
        null(true)
      end

      assert_equal false, inheriting_mutation.graphql_field.instance_variable_get("@return_type_null")
      assert override_mutation.graphql_field.instance_variable_get("@return_type_null")
    end
  end
end
