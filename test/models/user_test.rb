require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
  	@user = User.new(first_name: "Tim", last_name: "Arnold", user_type: "admin", password: "timothyarnold1", username: "tarnold")
  end

  test "should be valid" do
  	assert users(:admin).valid?
  end

  # presense

  test "first name should be present" do
  	@user.first_name = "   "
  	assert_not @user.valid?
  end

  test "lastName should be present" do
  	@user.last_name = "   "
  	assert_not @user.valid?
  end

  test "usertype should be present" do
    @user.user_type = "  "
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = "   "
    assert_not @user.valid?
  end

  test "username should be present" do
    @user.username = "   "
    assert_not @user.valid?
  end

  # length validation

  test "firstName should not be too long" do
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end

  test "lastName should not be too long" do
    @user.last_name = "a" * 51
    assert_not @user.valid?
  end

  test "username should not be too long" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end

  test "password should not be too long" do
    @user.password = "a" * 51
    assert_not @user.valid?
  end

  test "password should not be less than 6 characters" do
    @user.password = "a" * 5
    assert_not @user.valid?
  end

  test "username should be unique" do
  	duplicate_user = @user.dup
    duplicate_user.username = @user.username
  	@user.save
  	assert_not duplicate_user.valid?
  end

  test "username should be saved as lower case" do
    mixed_case_username = "UseRNaMe"
    @user.username = mixed_case_username
    @user.save
    assert_equal mixed_case_username.downcase, @user.reload.username
  end

  test "userType should be admin staff or client" do
    user_types = ['admin', 'staff', 'client']
    @user.user_type = 'cookie monster'
    assert_not(user_types.include? @user.user_type)
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

end
