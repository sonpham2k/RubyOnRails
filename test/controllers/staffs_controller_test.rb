require 'test_helper'

class StaffsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get staffs_new_url
    assert_response :success
  end

end
