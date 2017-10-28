require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Abilitree InTouch"
  end

  # test "should get root" do
  #   get "/"
  #   assert_response :success
  #   assert_select "title", "Login | #{@base_title}"
  # end

  test "should get login" do
    get root_path
    assert_response :success
    assert_select "title", "Login | #{@base_title}"
  end

  test "should get notifications" do
    get notifications_path
    assert_response :success
    assert_select "title", "Notifications | #{@base_title}"
  end

  test "should get users" do
   get users_path
   assert_response :success
   assert_select "title", "Users | #{@base_title}"
  end

  test "should get groups" do
    get groups_path
    assert_response :success
    assert_select "title", "Groups | #{@base_title}"
  end



end
