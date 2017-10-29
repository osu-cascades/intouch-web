require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(firstName: "Tim", lastName: "Arnold", userType: "admin", password: "tarnold", username: "tarnold")
  end

  test "should be valid" do 
  	assert @user.valid?
  end

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

  test "username should be unique" do
  	duplicate_user = @user.dup
  	@user.save
  	assert_not duplicate_user.valid?
  end

end
