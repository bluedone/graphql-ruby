# frozen_string_literal: true
require "spec_helper"

describe GraphQL::StaticValidation::ArgumentsAreDefined do
  include StaticValidationHelpers

  let(:query_string) {"
    query getCheese {
      okCheese: cheese(id: 1) { source }
      cheese(silly: false, id: 2) { source }
      searchDairy(product: [{wacky: 1}]) { ...cheeseFields }
    }

    fragment cheeseFields on Cheese {
      similarCheese(source: SHEEP, nonsense: 1) { __typename }
      id @skip(something: 3.4, if: false)
    }
  "}

  it "finds undefined arguments to fields and directives" do
    # There's an extra error here, the unexpected argument on "DairyProductInput"
    # triggers _another_ error that the field expected a different type
    assert_equal(5, errors.length)

    query_root_error = {
      "message"=>"Field 'cheese' doesn't accept argument 'silly'",
      "locations"=>[{"line"=>4, "column"=>14}],
      "path"=>["query getCheese", "cheese", "silly"],
      "extensions"=>{"rule"=>"StaticValidation::ArgumentsAreDefined", "type"=>"Field", "name"=>"cheese", "argument"=>"silly"}
    }
    assert_includes(errors, query_root_error)

    input_obj_record = {
      "message"=>"InputObject 'DairyProductInput' doesn't accept argument 'wacky'",
      "locations"=>[{"line"=>5, "column"=>30}],
      "path"=>["query getCheese", "searchDairy", "product", "wacky"],
      "extensions"=>{"rule"=>"StaticValidation::ArgumentsAreDefined", "type"=>"InputObject", "name"=>"DairyProductInput", "argument"=>"wacky"}
    }
    assert_includes(errors, input_obj_record)

    fragment_error = {
      "message"=>"Field 'similarCheese' doesn't accept argument 'nonsense'",
      "locations"=>[{"line"=>9, "column"=>36}],
      "path"=>["fragment cheeseFields", "similarCheese", "nonsense"],
      "extensions"=>{"rule"=>"StaticValidation::ArgumentsAreDefined", "type"=>"Field", "name"=>"similarCheese", "argument"=>"nonsense"}
    }
    assert_includes(errors, fragment_error)

    directive_error = {
      "message"=>"Directive 'skip' doesn't accept argument 'something'",
      "locations"=>[{"line"=>10, "column"=>16}],
      "path"=>["fragment cheeseFields", "id", "something"],
      "extensions"=>{"rule"=>"StaticValidation::ArgumentsAreDefined", "type"=>"Directive", "name"=>"skip", "argument"=>"something"}
    }
    assert_includes(errors, directive_error)
  end

  describe "dynamic fields" do
    let(:query_string) {"
      query {
        __type(somethingInvalid: 1) { name }
      }
    "}

    it "finds undefined arguments" do
      assert_includes(errors, {
        "message"=>"Field '__type' doesn't accept argument 'somethingInvalid'",
        "locations"=>[{"line"=>3, "column"=>16}],
        "path"=>["query", "__type", "somethingInvalid"],
        "extensions"=> {"rule"=>"StaticValidation::ArgumentsAreDefined", "type"=>"Field", "name"=>"__type", "argument"=>"somethingInvalid"}
      })
    end
  end
end
