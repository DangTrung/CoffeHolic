require "test_helper"

class CheckOutsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get check_outs_index_url
    assert_response :success
  end
end
