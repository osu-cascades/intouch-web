require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(firstName: "Tim", lastName: "Arnold", password: "tarnold", username: "tarnold")
  end

  test "should be valid" do 
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = "   "
  	assert_not @user.valid?
  end

end
