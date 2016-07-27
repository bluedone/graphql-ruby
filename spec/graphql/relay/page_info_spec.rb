require "spec_helper"

describe GraphQL::Relay::PageInfo do
  def get_page_info(result)
    result["data"]["empire"]["bases"]["pageInfo"]
  end

  def get_first_cursor(result)
    result["data"]["empire"]["bases"]["edges"].first["cursor"]
  end

  def get_last_cursor(result)
    result["data"]["empire"]["bases"]["edges"].last["cursor"]
  end

  let(:cursor_of_last_base) {
    result = query(query_string, "first" => 100)
    last_cursor = get_last_cursor(result)
  }

  let(:query_string) {%|
    query getShips($first: Int, $after: String, $last: Int, $before: String, $nameIncludes: String){
      empire {
        bases(first: $first, after: $after, last: $last, before: $before, nameIncludes: $nameIncludes) {
          edges {
            cursor
          }
          pageInfo {
            hasNextPage
            hasPreviousPage
            startCursor
            endCursor
          }
        }
      }
    }
  |}

  describe 'hasNextPage / hasPreviousPage' do
    it "hasNextPage is true if there are more items" do
      result = query(query_string, "first" => 2)
      assert_equal(true, get_page_info(result)["hasNextPage"])
      assert_equal(false, get_page_info(result)["hasPreviousPage"], "hasPreviousPage is false if 'last' is missing")
      assert_equal("MQ==", get_page_info(result)["startCursor"])
      assert_equal("Mg==", get_page_info(result)["endCursor"])

      last_cursor = get_last_cursor(result)
      result = query(query_string, "first" => 100, "after" => last_cursor)
      assert_equal(false, get_page_info(result)["hasNextPage"])
      assert_equal(false, get_page_info(result)["hasPreviousPage"])
      assert_equal("Mw==", get_page_info(result)["startCursor"])
      assert_equal("Mw==", get_page_info(result)["endCursor"])
    end

    it "hasPreviousPage if there are more items" do
      result = query(query_string, "last" => 100, "before" => cursor_of_last_base)
      assert_equal(false, get_page_info(result)["hasNextPage"])
      assert_equal(false, get_page_info(result)["hasPreviousPage"])
      assert_equal("MQ==", get_page_info(result)["startCursor"])
      assert_equal("Mg==", get_page_info(result)["endCursor"])

      result = query(query_string, "last" => 1, "before" => cursor_of_last_base)
      assert_equal(false, get_page_info(result)["hasNextPage"])
      assert_equal(true, get_page_info(result)["hasPreviousPage"])
      assert_equal("Mg==", get_page_info(result)["startCursor"])
      assert_equal("Mg==", get_page_info(result)["endCursor"])
    end

    it "has both if first and last are present" do
      result = query(query_string, "last" => 1, "first" => 1, "before" => cursor_of_last_base)
      assert_equal(true, get_page_info(result)["hasNextPage"])
      assert_equal(true, get_page_info(result)["hasPreviousPage"])
      assert_equal("Mg==", get_page_info(result)["startCursor"])
      assert_equal("Mg==", get_page_info(result)["endCursor"])
    end

    it "startCursor and endCursor are the cursors of the first and last edge" do
      result = query(query_string, "first" => 2)
      assert_equal(true, get_page_info(result)["hasNextPage"])
      assert_equal(false, get_page_info(result)["hasPreviousPage"])
      assert_equal("MQ==", get_page_info(result)["startCursor"])
      assert_equal("Mg==", get_page_info(result)["endCursor"])
      assert_equal("MQ==", get_first_cursor(result))
      assert_equal("Mg==", get_last_cursor(result))

      result = query(query_string, "first" => 1, "after" => get_page_info(result)["endCursor"])
      assert_equal(false, get_page_info(result)["hasNextPage"])
      assert_equal(false, get_page_info(result)["hasPreviousPage"])
      assert_equal("Mw==", get_page_info(result)["startCursor"])
      assert_equal("Mw==", get_page_info(result)["endCursor"])
      assert_equal("Mw==", get_first_cursor(result))
      assert_equal("Mw==", get_last_cursor(result))

      result = query(query_string, "last" => 1, "before" => get_page_info(result)["endCursor"])
      assert_equal(false, get_page_info(result)["hasNextPage"])
      assert_equal(true, get_page_info(result)["hasPreviousPage"])
      assert_equal("Mg==", get_page_info(result)["startCursor"])
      assert_equal("Mg==", get_page_info(result)["endCursor"])
      assert_equal("Mg==", get_first_cursor(result))
      assert_equal("Mg==", get_last_cursor(result))
    end
  end



end
