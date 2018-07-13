defmodule ExlasticSearch.ModelTest do
  use ExUnit.Case, async: true
  alias ExlasticSearch.TestModel
  describe "ES Schema functions" do
    test "__doc_type__" do
      assert TestModel.__doc_type__() == :test_model
    end

    test "__es_index__" do
      assert TestModel.__es_index__() == "test_models"
    end

    test "__es_mappings__" do
      %{properties: mappings} = TestModel.__es_mappings__()

      assert mappings.name.type == :text
      assert mappings.age.type == :long
      assert mappings.user.properties.ext_name.type == :text
    end

    test "es_decode" do
      %TestModel.SearchResult{} = result = TestModel.es_decode(%{
        "name" => "some_name", 
        "age" => 2, 
        "user" => %{
          "ext_name" => "other_name"
        }
      })

      assert result.name == "some_name"
      assert result.age == 2
      assert result.user.ext_name == "other_name"
    end

    test "search_query" do
      %ExlasticSearch.Query{queryable: q} = TestModel.search_query()

      assert q == TestModel
    end
  end
end