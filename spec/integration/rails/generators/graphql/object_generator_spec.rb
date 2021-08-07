# frozen_string_literal: true
require "spec_helper"
require "generators/graphql/object_generator"

class GraphQLGeneratorsObjectGeneratorTest < BaseGeneratorTest
  tests Graphql::Generators::ObjectGenerator

  ActiveRecord::Schema.define do
    create_table :test_users do |t|
      t.datetime :created_at
      t.date :birthday
      t.integer :points, null: false
      t.decimal :rating, null: false
    end
  end

  # rubocop:disable Style/ClassAndModuleChildren
  class ::TestUser < ActiveRecord::Base
  end
  # rubocop:enable Style/ClassAndModuleChildren

  test "it generates fields with types" do
    commands = [
      # GraphQL-style:
      ["Bird", "wingspan:Int!", "foliage:[Color]"],
      # Ruby-style:
      ["BirdType", "wingspan:!Integer", "foliage:[Types::ColorType]"],
      # Mixed
      ["BirdType", "wingspan:!Int", "foliage:[Color]"],
    ]

    expected_content = <<-RUBY
module Types::Objects
  class BirdType < Types::BaseObject
    field :wingspan, Integer, null: false
    field :foliage, [Types::ColorType], null: true
  end
end
RUBY

    commands.each do |c|
      prepare_destination
      run_generator(c)
      assert_file "app/graphql/types/objects/bird_type.rb", expected_content
    end
  end

  test "it generates classifed file" do
    run_generator(["page"])
    assert_file "app/graphql/types/objects/page_type.rb", <<-RUBY
module Types::Objects
  class PageType < Types::BaseObject
  end
end
RUBY
  end

  test "it makes Relay nodes" do
    run_generator(["Page", "--node"])
    assert_file "app/graphql/types/objects/page_type.rb", <<-RUBY
module Types::Objects
  class PageType < Types::BaseObject
    implements GraphQL::Types::Relay::Node
  end
end
RUBY
  end

  test "it generates objects based on ActiveRecord schema" do
    run_generator(["TestUser"])
    assert_file "app/graphql/types/objects/test_user_type.rb", <<-RUBY
module Types::Objects
  class TestUserType < Types::BaseObject
    field :id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :birthday, GraphQL::Types::ISO8601Date, null: true
    field :points, Integer, null: false
    field :rating, Float, null: false
  end
end
RUBY
  end

  test "it generates objects based on ActiveRecord schema with additional custom fields" do
    run_generator(["TestUser", "name:!String", "email:!Citext", "settings:jsonb"])
    assert_file "app/graphql/types/objects/test_user_type.rb", <<-RUBY
module Types::Objects
  class TestUserType < Types::BaseObject
    field :id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :birthday, GraphQL::Types::ISO8601Date, null: true
    field :points, Integer, null: false
    field :rating, Float, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :settings, GraphQL::Types::JSON, null: true
  end
end
RUBY
  end
end
