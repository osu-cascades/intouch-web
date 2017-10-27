require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Abilitree InTouch"
  end

  test "should get login" do
    get static_pages_login_url
    assert_response :success
    assert_select "title", "Login | #{@base_title}"
  end

  test "should get notifications" do
    get static_pages_notifications_url
    assert_response :success
    assert_select "title", "Notifications | #{@base_title}"
  end

  test "should get users" do
    get static_pages_users_url
    assert_response :success
    assert_select "title", "Users | #{@base_title}"
  end

  test "should get groups" do
    get static_pages_groups_url
    assert_response :success
    assert_select "title", "Groups | #{@base_title}"
  end

end
