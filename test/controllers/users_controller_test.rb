require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test_user)
    @user2 = users(:test_user2)
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@test_user2)
    get edit_user_path(@test_user)
    assert flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@test_user2)
    patch user_path(@test_user), params: 
                               { user: 
                               { first_name: @user.first_name,
                                 last_name: @user.last_name,
                                 usertype: @user.user_type,
                                 username: @user.username } }
    assert flash.empty?
    assert_redirected_to login_path
  end

end
