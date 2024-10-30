require "test_helper"

class ExamplesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get examples_index_url
    assert_response :success
  end

  test "should get show" do
    get examples_show_url
    assert_response :success
  end
end
