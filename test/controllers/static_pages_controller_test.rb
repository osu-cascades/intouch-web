require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get static_pages_login_url
    assert_response :success
  end

  test "should get notifications" do
    get static_pages_notifications_url
    assert_response :success
  end

  test "should get users" do
    get static_pages_users_url
    assert_response :success
  end

  test "should get groups" do
    get static_pages_groups_url
    assert_response :success
  end

end
