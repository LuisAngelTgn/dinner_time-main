require "test_helper"

class DataControllerTest < ActionDispatch::IntegrationTest
  test "should get load_data" do
    get data_load_data_url
    assert_response :success
  end
end
