require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test_user)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name:  "",
                                              last_name: "foo",
                                              user_type: 'client',
                                              username: 'fooman', password: "123456", 
                                              password_confirmation: "123456" } }

    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    first_name  = "Al"
    last_name = "Coholic"
    user_type = 'staff'
    username = "alcoholic"
    patch user_path(@user), params: { user: 
                                    { first_name:  first_name,
                                      last_name: last_name,
                                      user_type: user_type,
                                      username: username,     password: "123456",
                                      password_confirmation: "123456" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal first_name,  @user.first_name
    assert_equal last_name, @user.last_name
    assert_equal user_type,  @user.user_type
    assert_equal username, @user.username
  end

end
