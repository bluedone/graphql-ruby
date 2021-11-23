# frozen_string_literal: true
require "spec_helper"

describe GraphQL::Schema::InputObject do
  let(:input_object) { Jazz::EnsembleInput }

  describe ".path" do
    it "is the name" do
      assert_equal "EnsembleInput", input_object.path
    end

    it "is used in argument paths" do
      assert_equal "EnsembleInput.name", input_object.arguments["name"].path
    end
  end

  describe "type info" do
    it "has it" do
      assert_equal "EnsembleInput", input_object.graphql_name
      assert_equal nil, input_object.description
      assert_equal 1, input_object.arguments.size
    end

    it "returns newly-added argument definitions" do
      arg = nil
      Class.new(GraphQL::Schema::InputObject) do
        arg = argument(:int, Integer)
      end
      assert_instance_of GraphQL::Schema::Argument, arg
    end

    it "is the #owner of its arguments" do
      argument = input_object.arguments["name"]
      assert_equal input_object, argument.owner
    end

    it "inherits arguments" do
      base_class = Class.new(GraphQL::Schema::InputObject) do
        argument :arg1, String
        argument :arg2, String
      end

      subclass = Class.new(base_class) do
        argument :arg2, Integer
        argument :arg3, Integer
      end

      ensemble_class = Class.new(subclass) do
        argument :ensemble_id, GraphQL::Types::ID, required: false, loads: Jazz::Ensemble
      end

      assert_equal 3, subclass.arguments.size
      assert_equal ["arg1", "arg2", "arg3"], subclass.arguments.keys
      assert_equal ["String!", "Int!", "Int!"], subclass.arguments.values.map { |a| a.type.to_type_signature }
      assert_equal ["String!", "Int!", "Int!", "ID"], ensemble_class.arguments.values.map { |a| a.type.to_type_signature }
      assert_equal :ensemble, ensemble_class.arguments["ensembleId"].keyword
    end
  end

  describe ".to_graphql" do
    it "assigns itself as the arguments_class" do
      assert_equal input_object, input_object.to_graphql.arguments_class
    end

    it "accepts description: kwarg" do
      input_obj_class = Jazz::InspectableInput
      input_obj_type = input_obj_class.to_graphql
      assert_equal "Test description kwarg", input_obj_type.arguments["stringValue"].description
    end
  end

  describe "camelizing with numbers" do
    module InputObjectWithNumbers
      class InputObject < GraphQL::Schema::InputObject
        argument :number_arg1, Integer, required: false
        argument :number_arg_2, Integer, required: false
        argument :number_arg3, Integer, required: false, camelize: false
        argument :number_arg_4, Integer, required: false, camelize: false
        argument :numberArg5, Integer, required: false
        argument :numberArg6, Integer, required: false, camelize: false
      end
    end

    it "accepts leading underscores or _no_ underscores" do
      input_obj = InputObjectWithNumbers::InputObject
      assert_equal ["numberArg1", "numberArg2", "number_arg3", "number_arg_4", "numberArg5", "numberArg6"], input_obj.arguments.keys
      assert_equal ["numberArg1", "numberArg2", "number_arg3", "number_arg_4", "numberArg5", "numberArg6"], input_obj.arguments.values.map(&:graphql_name)
      assert_equal :number_arg1, input_obj.arguments["numberArg1"].keyword
      assert_equal :number_arg_2, input_obj.arguments["numberArg2"].keyword
      assert_equal :number_arg3, input_obj.arguments["number_arg3"].keyword
      assert_equal :number_arg_4, input_obj.arguments["number_arg_4"].keyword
      assert_equal :numberArg5, input_obj.arguments["numberArg5"].keyword
      assert_equal :numberArg6, input_obj.arguments["numberArg6"].keyword
    end
  end

  describe "prepare with camelized inputs" do
    class PrepareCamelizedSchema < GraphQL::Schema
      class CamelizedInput < GraphQL::Schema::InputObject
        argument :inputString, String,
          camelize: false,
          as: :input_string,
          prepare: ->(val, ctx) { val.upcase }
      end

      class Query < GraphQL::Schema::Object
        field :input_test, String, null: false do
          argument :camelized_input, CamelizedInput
        end

        def input_test(camelized_input:)
          camelized_input[:input_string]
        end
      end

      query(Query)
    end

    it "calls the prepare proc" do
      res = PrepareCamelizedSchema.execute("{ inputTest(camelizedInput: { inputString: \"abc\" }) }")
      assert_equal "ABC", res["data"]["inputTest"]
    end
  end

  describe "prepare: / loads: / as:" do
    module InputObjectPrepareTest
      class InputObj < GraphQL::Schema::InputObject
        argument :a, Integer
        argument :b, Integer, as: :b2
        argument :c, Integer, prepare: :prep
        argument :d, Integer, prepare: :prep, as: :d2
        argument :e, Integer, prepare: ->(val, ctx) { val * ctx[:multiply_by] * 2 }, as: :e2
        argument :instrument_id, ID, loads: Jazz::InstrumentType
        argument :danger, Integer, required: false, prepare: ->(val, ctx) { raise GraphQL::ExecutionError.new('boom!') }

        def prep(val)
          val * context[:multiply_by]
        end
      end

      class Query < GraphQL::Schema::Object
        field :inputs, [String], null: false do
          argument :input, InputObj
        end

        def inputs(input:)
          [input.to_kwargs.inspect, input.instrument.name]
        end
      end

      class Mutation < GraphQL::Schema::Object
        class InstrumentInput < GraphQL::Schema::InputObject
          argument :instrument_id, ID, loads: Jazz::InstrumentType
        end

        class TouchInstrument < GraphQL::Schema::Mutation
          argument :input_obj, InstrumentInput
          field :instrument_name_method, String, null: false
          field :instrument_name_key, String, null: false

          def resolve(input_obj:)
            # Make sure both kinds of access work the same:
            {
              instrument_name_method: input_obj.instrument.name,
              instrument_name_key: input_obj[:instrument].name,
            }
          end
        end

        class InstrumentByNameInput < GraphQL::Schema::InputObject
          argument :instrument_name, ID, loads: Jazz::InstrumentType, as: :instrument

          def self.load_instrument(instrument_name, context)
            -> {
              instruments = Jazz::Models.data["Instrument"]
              instruments.find { |i| i.name == instrument_name }
            }
          end
        end

        class TouchInstrumentByName < TouchInstrument
          argument :input_obj, InstrumentByNameInput
        end

        field :touch_instrument, mutation: TouchInstrument
        field :touch_instrument_by_name, mutation: TouchInstrumentByName

        class ListInstruments < GraphQL::Schema::Mutation
          argument :list, [InstrumentInput]
          field :resolved_list, String, null: false

          def resolve(list:)
            {
              resolved_list: list.map(&:to_kwargs).inspect
            }
          end
        end

        field :list_instruments, mutation: ListInstruments
      end

      class Schema < GraphQL::Schema
        query(Query)
        mutation(Mutation)
        lazy_resolve(Proc, :call)

        def self.object_from_id(id, ctx)
          -> { Jazz::GloballyIdentifiableType.find(id) }
        end

        def self.resolve_type(type, obj, ctx)
          type
        end

        orphan_types [Jazz::InstrumentType]
        max_complexity 100
      end
    end

    it "calls methods on the input object" do
      query_str = <<-GRAPHQL
      { inputs(input: { a: 1, b: 2, c: 3, d: 4, e: 5, instrumentId: "Instrument/Drum Kit" }) }
      GRAPHQL

      res = InputObjectPrepareTest::Schema.execute(query_str, context: { multiply_by: 3 })
      expected_obj = [{ a: 1, b2: 2, c: 9, d2: 12, e2: 30, instrument: Jazz::Models::Instrument.new("Drum Kit", "PERCUSSION") }.inspect, "Drum Kit"]
      assert_equal expected_obj, res["data"]["inputs"]
    end

    it "calls load_ methods for arguments when they're present" do
      query_str = <<-GRAPHQL
      mutation {
        touchInstrumentByName(inputObj: { instrumentName: "Flute" }) {
          instrumentNameMethod
          instrumentNameKey
        }
      }
      GRAPHQL

      res = InputObjectPrepareTest::Schema.execute(query_str)
      assert_equal "Flute", res["data"]["touchInstrumentByName"]["instrumentNameMethod"]
      assert_equal "Flute", res["data"]["touchInstrumentByName"]["instrumentNameKey"]
    end

    it "handles exceptions preparing variable input objects" do
      query_str = <<-GRAPHQL
      query($input: InputObj!){ inputs(input: $input) }
      GRAPHQL

      input = { "a" => 1, "b" => 2, "c" => 3, "d" => 4, "e" => 5, "instrumentId" => "Instrument/Drum Kit", "danger" => 1 }
      res = InputObjectPrepareTest::Schema.execute(query_str, context: { multiply_by: 3 },
                                                   variables: { input: input})
      assert_nil(res["data"])

      assert_equal("boom!", res["errors"][0]["message"])
      assert_equal([{ "line" => 1, "column" => 33 }], res["errors"][0]["locations"])
    end

    it "handles not-found with max complexity analyzer running" do
      query_str = <<-GRAPHQL
      { inputs(input: {a: 1, b: 2, c: 3, d: 4, e: 6, instrumentId: "Instrument/Nonsense"}) }
      GRAPHQL

      res = InputObjectPrepareTest::Schema.execute(
        query_str,
        context: { multiply_by: 3 }
      )

      assert_equal ["No object found for `instrumentId: \"Instrument/Nonsense\"`"], res["errors"].map { |e| e["message"] }
    end

    it "loads input object arguments" do
      query_str = <<-GRAPHQL
      mutation {
        touchInstrument(inputObj: { instrumentId: "Instrument/Drum Kit" }) {
          instrumentNameMethod
          instrumentNameKey
        }
      }
      GRAPHQL

      res = InputObjectPrepareTest::Schema.execute(query_str)
      assert_equal "Drum Kit", res["data"]["touchInstrument"]["instrumentNameMethod"]
      assert_equal "Drum Kit", res["data"]["touchInstrument"]["instrumentNameKey"]
    end

    it "loads nested input object arguments" do
      query_str = <<-GRAPHQL
      mutation {
        listInstruments(list: [{ instrumentId: "Instrument/Drum Kit" }]) {
          resolvedList
        }
      }
      GRAPHQL

      res = InputObjectPrepareTest::Schema.execute(query_str)
      expected_obj = [{ instrument: Jazz::Models::Instrument.new("Drum Kit", "PERCUSSION") }].inspect
      assert_equal expected_obj, res["data"]["listInstruments"]["resolvedList"]
    end
  end

  describe "prepare (entire input object)" do
    module InputObjectPrepareObjectTest
      class InputObj < GraphQL::Schema::InputObject
        argument :min, Integer
        argument :max, Integer, required: false

        def prepare
          min..max
        end
      end

      class Query < GraphQL::Schema::Object
        field :inputs, String, null: false do
          argument :input, InputObj
        end

        def inputs(input:)
          input.inspect
        end
      end

      class Schema < GraphQL::Schema
        query(Query)
      end
    end

    it "calls prepare on the input object (literal)" do
      query_str = <<-GRAPHQL
      { inputs(input: { min: 5, max: 10 }) }
      GRAPHQL

      res = InputObjectPrepareObjectTest::Schema.execute(query_str)
      expected_obj = (5..10).inspect
      assert_equal expected_obj, res["data"]["inputs"]
    end

    it "calls prepare on the input object (variable)" do
      query_str = <<-GRAPHQL
      query ($input: InputObj!){ inputs(input: $input) }
      GRAPHQL

      res = InputObjectPrepareObjectTest::Schema.execute(query_str, variables: { input: { min: 5, max: 10 } })
      expected_obj = (5..10).inspect
      assert_equal expected_obj, res["data"]["inputs"]
    end
  end

  describe "loading application object(s)" do
    module InputObjectLoadsTest
      class BaseArgument < GraphQL::Schema::Argument
        def authorized?(obj, val, ctx)
          if contains_spinal_tap?(val)
            false
          else
            true
          end
        end

        def contains_spinal_tap?(val)
          if val.is_a?(Array)
            val.any? { |v| contains_spinal_tap?(v) }
          else
            val.is_a?(Jazz::Models::Ensemble) && val.name == "Spinal Tap"
          end
        end
      end

      class SingleLoadInputObj < GraphQL::Schema::InputObject
        argument_class BaseArgument
        argument :instrument_id, ID, loads: Jazz::InstrumentType
      end

      class MultiLoadInputObj < GraphQL::Schema::InputObject
        argument_class BaseArgument
        argument :instrument_ids, [ID], loads: Jazz::InstrumentType
      end

      class Query < GraphQL::Schema::Object
        field :single_load_input, Jazz::InstrumentType do
          argument :input, SingleLoadInputObj
        end
        field :multi_load_input, [Jazz::InstrumentType] do
          argument :input, MultiLoadInputObj
        end

        def single_load_input(input:)
          input.instrument
        end

        def multi_load_input(input:)
          input.instruments
        end
      end

      class Schema < GraphQL::Schema
        query(Query)

        def self.object_from_id(id, ctx)
          Jazz::GloballyIdentifiableType.find(id)
        end

        def self.resolve_type(type, obj, ctx)
          type
        end
      end
    end

    let(:single_query_str) {
      <<-GRAPHQL
        query($id: ID!) {
          singleLoadInput(input: {instrumentId: $id}) {
            id
          }
        }
      GRAPHQL
    }

    let(:multi_query_str) {
      <<-GRAPHQL
        query($ids: [ID!]!) {
          multiLoadInput(input: {instrumentIds: $ids}) {
            id
          }
        }
      GRAPHQL
    }

    it "loads arguments as objects of the given type and strips `_id` suffix off argument name" do
      res = InputObjectLoadsTest::Schema.execute(single_query_str, variables: { id: "Ensemble/Robert Glasper Experiment" })
      assert_equal "Ensemble/Robert Glasper Experiment", res["data"]["singleLoadInput"]["id"]
    end

    it "loads arguments as objects of the given type and strips `_ids` suffix off argument name and appends `s`" do
      res = InputObjectLoadsTest::Schema.execute(multi_query_str, variables: { ids: ["Ensemble/Robert Glasper Experiment", "Ensemble/Bela Fleck and the Flecktones"]})
      assert_equal ["Ensemble/Robert Glasper Experiment", "Ensemble/Bela Fleck and the Flecktones"], res["data"]["multiLoadInput"].map { |e| e["id"] }
    end

    it "authorizes based on loaded objects" do
      res = InputObjectLoadsTest::Schema.execute(single_query_str, variables: { id: "Ensemble/Spinal Tap" })
      assert_nil res["data"]["singleLoadInput"]

      res2 = InputObjectLoadsTest::Schema.execute(multi_query_str, variables: { ids: ["Ensemble/Robert Glasper Experiment", "Ensemble/Spinal Tap"]})
      assert_nil res2["data"]["multiLoadInput"]
    end
  end

  describe "in queries" do
    it "is passed to the field method" do
      query_str = <<-GRAPHQL
      {
        inspectInput(input: {
          stringValue: "ABC",
          legacyInput: { intValue: 4 },
          nestedInput: { stringValue: "xyz"},
          ensembleId: "Ensemble/Robert Glasper Experiment"
        })
      }
      GRAPHQL

      res = Jazz::Schema.execute(query_str, context: { message: "hi" })
      expected_info = [
        "Jazz::InspectableInput",
        "hi, ABC, 4, (hi, xyz, -, (-))",
        "ABC",
        "ABC",
        "true",
        "ABC",
        Jazz::Models::Ensemble.new("Robert Glasper Experiment").to_s,
        "true",
      ]
      assert_equal expected_info, res["data"]["inspectInput"]
    end

    it "works with given nil values for nested inputs" do
      query_str = <<-GRAPHQL
      query($input: InspectableInput!){
        inspectInput(input: $input)
      }
      GRAPHQL
      input = {
        "nestedInput" => nil,
        "stringValue" => "xyz"
      }
      res = Jazz::Schema.execute(query_str, variables: { input: input }, context: { message: "hi" })
      assert res["data"]["inspectInput"]
    end

    it "uses empty object when no variable value is given" do
      query_str = <<-GRAPHQL
      query($input: InspectableInput){
        inspectInput(input: {
          nestedInput: $input,
          stringValue: "xyz"
        })
      }
      GRAPHQL

      res = Jazz::Schema.execute(query_str, variables: { input: nil }, context: { message: "hi" })
      expected_info = [
        "Jazz::InspectableInput",
        "hi, xyz, -, (-)",
        "xyz",
        "xyz",
        "true",
        "xyz",
        "No ensemble",
        "false"
      ]

      assert_equal expected_info, res["data"]["inspectInput"]
    end

    it "handles camelized booleans" do
      res = Jazz::Schema.execute("query($input: CamelizedBooleanInput!){ inputObjectCamelization(input: $input) }", variables: { input: { camelizedBoolean: false } })
      assert_equal "{:camelized_boolean=>false}", res["data"]["inputObjectCamelization"]
    end
  end

  describe "when used with default_value" do
    it "comes as an instance" do
      res = Jazz::Schema.execute("{ defaultValueTest }")
      assert_equal "Jazz::InspectableInput -> {:string_value=>\"S\"}", res["data"]["defaultValueTest"]
    end

    it "works with empty objects" do
      res = Jazz::Schema.execute("{ defaultValueTest2 }")
      assert_equal "Jazz::FullyOptionalInput -> {}", res["data"]["defaultValueTest2"]
    end

    it "introspects in GraphQL language with enums" do
      class InputDefaultSchema < GraphQL::Schema
        class Letter < GraphQL::Schema::Enum
          value "A", value: 1
          value "B", value: 2
        end

        class InputObj < GraphQL::Schema::InputObject
          argument :arg_a, Letter, required: false
          argument :arg_b, Letter, required: false
        end

        class Query < GraphQL::Schema::Object
          field :i, Int do
            argument :arg, InputObj, required: false, default_value: { arg_a: 1, arg_b: 2 }
          end
        end

        query(Query)
      end

      res = InputDefaultSchema.execute "
      {
        __type(name: \"Query\") {
          fields {
            name
            args {
              name
              defaultValue
            }
          }
        }
      }
      "
      assert_equal "{argA: A, argB: B}", res["data"]["__type"]["fields"].first["args"].first["defaultValue"]
    end
  end

  describe 'hash conversion behavior' do
    module InputObjectToHTest
      class TestInput1 < GraphQL::Schema::InputObject
        graphql_name "TestInput1"
        argument :d, Int
        argument :e, Int
        argument :instrument_id, ID, loads: Jazz::InstrumentType
      end

      class TestInput2 < GraphQL::Schema::InputObject
        graphql_name "TestInput2"
        argument :a, Int
        argument :b, Int
        argument :c, TestInput1, as: :inputObject
      end

      TestInput1.to_graphql
      TestInput2.to_graphql
    end

    before do
      arg_values = {a: 1, b: 2, c: { d: 3, e: 4, instrumentId: "Instrument/Drum Kit"}}

      query = GraphQL::Query.new(Jazz::Schema, "{ __typename }")
      # This is because a test below expects `instrument:` to have been loaded
      # during `InputObject#initialize`, which only happens when `!context.interpreter?`.
      # Maybe that test could be updated instead.
      context_without_interpreter = Class.new(SimpleDelegator) do
        def interpreter?
          false
        end
      end

      @input_object = InputObjectToHTest::TestInput2.new(
        arg_values,
        context: context_without_interpreter.new(query.context),
        defaults_used: Set.new
      )
    end

    describe "#to_h" do
      it "returns a symbolized, aliased, ruby keyword style hash" do
        assert_equal({ a: 1, b: 2, input_object: { d: 3, e: 4, instrument: Jazz::Models::Instrument.new("Drum Kit", "PERCUSSION") } }, @input_object.to_h)
      end
    end

    describe "#to_hash" do
      it "returns the same results as #to_h (aliased)" do
        assert_equal(@input_object.to_h, @input_object.to_hash)
      end
    end
  end

  describe "#dig" do
    module InputObjectDigTest
      class TestInput1 < GraphQL::Schema::InputObject
        graphql_name "TestInput1"
        argument :d, Int
        argument :e, Int
      end

      class TestInput2 < GraphQL::Schema::InputObject
        graphql_name "TestInput2"
        argument :a, Int
        argument :b, Int
        argument :c, TestInput1, as: :inputObject
      end

      TestInput1.to_graphql
      TestInput2.to_graphql
    end
    arg_values = {a: 1, b: 2, c: { d: 3, e: 4 }}

    input_object = InputObjectDigTest::TestInput2.new(
      arg_values,
      context: nil,
      defaults_used: Set.new
    )
    it "returns the value at that key" do
      assert_equal 1, input_object.dig("a")
      assert_equal 1, input_object.dig(:a)
      assert input_object.dig("inputObject").is_a?(GraphQL::Schema::InputObject)
    end

    it "works with nested keys" do
      assert_equal 3, input_object.dig("inputObject", "d")
      assert_equal 3, input_object.dig(:inputObject, :d)
      assert_equal 3, input_object.dig("inputObject", :d)
      assert_equal 3, input_object.dig(:inputObject, "d")
    end

    it "returns nil for missing keys" do
      assert_nil input_object.dig("z")
      assert_nil input_object.dig(7)
    end

    it "handles underscored keys" do
      # TODO - shouldn't this work too?
      # assert_equal 3, input_object.dig('input_object', 'd')
      assert_equal 3, input_object.dig(:input_object, :d)
    end
  end

  describe "introspection" do
    it "returns input fields" do
      res = Jazz::Schema.execute('
        {
          __type(name: "InspectableInput") {
            name
            inputFields { name }
          }
          __schema {
            types {
              name
              inputFields { name }
            }
          }
        }')
      # Test __type
      assert_equal ["ensembleId", "stringValue", "nestedInput", "legacyInput"], res["data"]["__type"]["inputFields"].map { |f| f["name"] }
      # Test __schema { types }
      # It's upcased to test custom introspection
      input_type = res["data"]["__schema"]["types"].find { |t| t["name"] == "INSPECTABLEINPUT" }
      assert_equal ["ensembleId", "stringValue", "nestedInput", "legacyInput"], input_type["inputFields"].map { |f| f["name"] }
    end
  end

  describe "warning for method objects" do
    it "warns for method conflicts" do
      input_object = Class.new(GraphQL::Schema::InputObject) do
        graphql_name "X"
        argument :method, String
      end

      expected_warning = "Unable to define a helper for argument with name 'method' as this is a reserved name. Add `method_access: false` to stop this warning."

      messages = []
      GraphQL::Deprecation.stub(:warn, ->(message) { messages << message; nil }) do
        input_object.graphql_definition
      end
      assert_equal [expected_warning], messages
    end

    it "doesn't warn with `method_access: false`" do
      input_object = Class.new(GraphQL::Schema::InputObject) do
        graphql_name "X"
        argument :method, String, method_access: false
      end

      assert_output "", "" do
        input_object.graphql_definition
      end
    end
  end

  describe "nested objects inside lists" do
    class NestedInputObjectSchema < GraphQL::Schema
      class ItemInput < GraphQL::Schema::InputObject
        argument :str, String
      end

      class NestedStuff < GraphQL::Schema::RelayClassicMutation
        argument :items, [ItemInput]
        field :str, String, null: false
        def resolve(items:)
          {
            str: items.map { |i| i.class.name }.join(", ")
          }
        end
      end

      class Mutation < GraphQL::Schema::Object
        field :nested_stuff, mutation: NestedStuff
      end

      mutation(Mutation)
    end

    it "properly wraps them in instances" do
      res = NestedInputObjectSchema.execute "
        mutation($input: NestedStuffInput!) {
          nestedStuff(input: $input) {
            str
          }
        }
      ", variables: { input: { "items" => [{ "str" => "1"}, { "str" => "2"}]}}
      assert_equal "NestedInputObjectSchema::ItemInput, NestedInputObjectSchema::ItemInput", res["data"]["nestedStuff"]["str"]
    end
  end

  describe 'default values' do
    describe 'when the type is an enum with underlying ruby values' do
      it 'provides the default value' do
        class TestEnum < GraphQL::Schema::Enum
          value 'A', 'Represents an authorized agent in our system.', value: 'a'
          value 'B', 'Agent is disabled, web app access is denied.', value: 'b'
        end

        class TestInput < GraphQL::Schema::InputObject
          argument :foo, TestEnum, 'TestEnum', required: false, default_value: 'a'
        end

        test_input_type = TestInput
        default_test_input_value = test_input_type.coerce_isolated_input({})
        assert_equal default_test_input_value[:foo], 'a'
      end
    end

    describe "when it's an empty object" do
      it "is passed in" do
        input_obj = Class.new(GraphQL::Schema::InputObject) do
          graphql_name "InputObj"
          argument :s, String, required: false
        end

        query = Class.new(GraphQL::Schema::Object) do
          graphql_name "Query"
          field :f, String do
            argument :arg, input_obj, required: false, default_value: {}
          end

          def f(arg:)
            arg.to_h.inspect
          end
        end

        schema = Class.new(GraphQL::Schema) do
          query(query)
        end

        res = schema.execute("{ f } ")
        assert_equal "{}", res["data"]["f"]
      end
    end
  end

  describe "tests from legacy input_object_type" do
    let(:input_object) { Dummy::DairyProductInput }

    def validate_isolated_input(t, input)
      t.validate_input(input, GraphQL::Query::NullContext)
    end

    describe "input validation" do
      it "Accepts anything that yields key-value pairs to #all?" do
        values_obj = MinimumInputObject.new({"source" => "COW", "fatContent" => 0.4})
        assert input_object.valid_isolated_input?(values_obj)
      end

      describe "validate_input with non-enumerable input" do
        it "returns a valid result for MinimumInputObject" do
          result = validate_isolated_input(input_object, MinimumInputObject.new({"source" => "COW", "fatContent" => 0.4}))
          assert(result.valid?)
        end

        it "returns an invalid result for MinimumInvalidInputObject" do
          invalid_input = MinimumInputObject.new({"source" => "KOALA", "fatContent" => 0.4})
          result = validate_isolated_input(input_object, invalid_input)
          assert(!result.valid?)
        end
      end

      describe "validate_input with null" do
        let(:schema) { GraphQL::Schema.from_definition(%|
          type Query {
            a: Int
          }

          input ExampleInputObject {
            a: String
            b: Int!
          }
        |) }
        let(:input_type) { schema.types['ExampleInputObject'] }

        it "returns an invalid result when value is null for non-null argument" do
          invalid_input = MinimumInputObject.new({"a" => "Test", "b" => nil})
          result = validate_isolated_input(input_type, invalid_input)
          assert(!result.valid?)
        end

        it "returns valid result when value is null for nullable argument" do
          invalid_input = MinimumInputObject.new({"a" => nil, "b" => 1})
          result = validate_isolated_input(input_type, invalid_input)
          assert(result.valid?)
        end
      end

      describe "validate_input with enumerable input" do
        describe "with good input" do
          it "returns a valid result" do
            input = {
              "source" => "COW",
              "fatContent" => 0.4
            }
            result = validate_isolated_input(input_object, input)
            assert(result.valid?)
          end
        end

        if testing_rails? && ActionPack::VERSION::MAJOR > 3
          it "returns a valid result" do
            input = ActionController::Parameters.new(
              "source" => "COW",
              "fatContent" => 0.4,
            )
            result = validate_isolated_input(input_object, input)
            assert_nil result.problems
            assert(result.valid?)
          end
        end

        describe "with bad enum and float" do
          let(:result) { validate_isolated_input(input_object, {"source" => "KOALA", "fatContent" => "bad_num"}) }

          it "returns an invalid result" do
            assert(!result.valid?)
          end

          it "has problems with correct paths" do
            paths = result.problems.map { |p| p["path"] }
            assert(paths.include?(["source"]))
            assert(paths.include?(["fatContent"]))
          end

          it "has correct problem explanation" do
            expected = validate_isolated_input(Dummy::DairyAnimal, "KOALA").problems[0]["explanation"]

            source_problem = result.problems.detect { |p| p["path"] == ["source"] }
            actual = source_problem["explanation"]

            assert_equal(expected, actual)
          end
        end

        describe 'with a string as input' do
          let(:result) { validate_isolated_input(input_object, "just a string") }

          it "returns an invalid result" do
            assert(!result.valid?)
          end

          it "has problem with correct path" do
            paths = result.problems.map { |p| p["path"] }
            assert(paths.include?([]))
          end

          it "has correct problem explanation" do
            assert_includes result.problems[0]["explanation"], "to be a key-value object"
          end
        end

        describe 'with an array as input' do
          let(:result) { validate_isolated_input(input_object, ["string array"]) }

          it "returns an invalid result" do
            assert(!result.valid?)
          end

          it "has problem with correct path" do
            paths = result.problems.map { |p| p["path"] }
            assert(paths.include?([]))
          end

          it "has correct problem explanation" do
            assert_includes result.problems[0]["explanation"], "to be a key-value object"
          end
        end

        describe 'with a int as input' do
          let(:result) { validate_isolated_input(input_object, 10) }

          it "returns an invalid result" do
            assert(!result.valid?)
          end

          it "has problem with correct path" do
            paths = result.problems.map { |p| p["path"] }
            assert(paths.include?([]))
          end

          it "has correct problem explanation" do
            assert_includes result.problems[0]["explanation"], "to be a key-value object"
          end
        end

        describe "with extra argument" do
          let(:result) { validate_isolated_input(input_object, {"source" => "COW", "fatContent" => 0.4, "isDelicious" => false}) }

          it "returns an invalid result" do
            assert(!result.valid?)
          end

          it "has problem with correct path" do
            paths = result.problems.map { |p| p["path"] }
            assert_equal([["isDelicious"]], paths)
          end

          it "has correct problem explanation" do
            assert(result.problems[0]["explanation"].include?("Field is not defined"))
          end
        end

        describe "list with one invalid element" do
          let(:list_type) { Dummy::DairyProductInput.to_list_type }
          let(:result) do
            validate_isolated_input(list_type, [
              { "source" => "COW", "fatContent" => 0.4 },
              { "source" => "KOALA", "fatContent" => 0.4 }
            ])
          end

          it "returns an invalid result" do
            assert(!result.valid?)
          end

          it "has one problem" do
            assert_equal(result.problems.length, 1)
          end

          it "has problem with correct path" do
            path = result.problems[0]["path"]
            assert_equal(path, [1, "source"])
          end

          it "has problem with correct explanation" do
            expected = validate_isolated_input(Dummy::DairyAnimal, "KOALA").problems[0]["explanation"]
            actual = result.problems[0]["explanation"]
            assert_equal(expected, actual)
          end
        end
      end
    end

    describe "coerce_result" do
      it "omits unspecified arguments" do
        result = input_object.coerce_isolated_result({fatContent: 0.3})
        assert_equal ["fatContent"], result.keys
        assert_equal 0.3, result["fatContent"]
      end
    end

    describe "coercion of null inputs" do
      let(:schema) { GraphQL::Schema.from_definition(%|
        type Query {
          a: Int
        }

        input ExampleInputObject {
          a: String
          b: Int!
          c: String = "Default"
          d: Boolean = false
        }

        input SecondLevelInputObject {
          example: ExampleInputObject = {b: 42, d: true}
        }
      |) }
      let(:input_type) { schema.types['ExampleInputObject'] }

      it "null values are returned in coerced input" do
        input = MinimumInputObject.new({"a" => "Test", "b" => nil,"c" => "Test"})
        result = input_type.coerce_isolated_input(input)

        assert_equal 'Test', result[:a]

        assert result.key?(:b)
        assert_nil result[:b]

        assert_equal "Test", result[:c]
      end

      it "null values are preserved when argument has a default value" do
        input = MinimumInputObject.new({"a" => "Test", "b" => 1, "c" => nil})
        result = input_type.coerce_isolated_input(input)

        assert_equal 'Test', result[:a]
        assert_equal 1, result[:b]

        assert result.key?(:c)
        assert_nil result[:c]
      end

      it "omitted arguments are not returned" do
        input = MinimumInputObject.new({"b" => 1, "c" => "Test"})
        result = input_type.coerce_isolated_input(input)

        assert !result.key?(:a)
        assert_equal 1, result[:b]
        assert_equal 'Test', result[:c]
      end

      it "false default values are returned" do
        input = MinimumInputObject.new({"b" => 1})
        result = input_type.coerce_isolated_input(input)

        assert_equal false, result[:d]
      end

      it "merges defaults of nested input objects" do
        result = schema.types['SecondLevelInputObject'].coerce_isolated_input({})
        assert_equal 42, result[:example][:b]
        assert_equal "Default", result[:example][:c]
        assert_equal true, result[:example][:d]
      end
    end

    describe "when sent into a query" do
      let(:variables) { {} }
      let(:result) { Dummy::Schema.execute(query_string, variables: variables) }

      describe "list inputs" do
        let(:variables) { {"search" => [MinimumInputObject.new({"source" => "COW", "fatContent" => 0.4})]} }
        let(:query_string) {%|
          query getCheeses($search: [DairyProductInput]!){
              sheep: searchDairy(product: [{source: SHEEP, fatContent: 0.1}]) {
                ... cheeseFields
              }
              cow: searchDairy(product: $search) {
                ... cheeseFields
              }
          }

          fragment cheeseFields on Cheese {
            flavor
          }
        |}

        it "converts items to plain values" do
          sheep_value = result["data"]["sheep"]["flavor"]
          cow_value = result["data"]["cow"]["flavor"]
          assert_equal("Manchego", sheep_value)
          assert_equal("Brie", cow_value)
        end
      end
    end
  end
end
