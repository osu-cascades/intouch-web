require 'test_helper'

class RoleTest < ActiveSupport::TestCase

 def setup
    @role = Role.new(name: "Staff")
  end

  test "should be valid" do
    assert @role.valid?
  end

  test "role name should be present" do
    @role.name = "     "
    assert_not @role.valid?
  end

  test "role name should not be too long" do
    @role.name = "a" * 101
    assert_not @role.valid?
  end


end
