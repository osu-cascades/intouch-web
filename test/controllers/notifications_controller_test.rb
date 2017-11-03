require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get notifications_new_url
    assert_response :success
  end

end
