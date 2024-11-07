require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    # home index is root, get request deleted for pretty url
    # get home_index_url
    get root_path
    assert_response :success
  end
end
