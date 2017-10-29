require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(firstName: "Tim", lastName: "Arnold", userType: "admin", password: "timothyarnold1", username: "tarnold")
  end

  test "should be valid" do 
  	assert @user.valid?
  end

  # presense

  test "firstName should be present" do
  	@user.firstName = "   "
  	assert_not @user.valid?
  end

  test "lastName should be present" do
  	@user.lastName = "   "
  	assert_not @user.valid?
  end

  test "usertype should be present" do
    @user.userType = "  "
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
    @user.firstName = "a" * 51
    assert_not @user.valid?
  end

  test "lastName should not be too long" do
    @user.lastName = "a" * 51
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

  test "password should not be less than 14 characters" do
    @user.password = "a" * 13
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

  test "userType should be \'admin\', \'staff\', or \'client\'" do
    userTypes = ['admin', 'staff', 'client']
    @user.userType = 'cookie monster'
    assert_not(userTypes.include? @user.userType)
  end

end
