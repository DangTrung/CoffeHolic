require "test_helper"

class Admin::DashBoardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_dash_boards_index_url
    assert_response :success
  end
end
