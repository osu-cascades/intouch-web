require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  
  def setup
    @group = Group.new(name: "All Clients")
  end

  test "should be valid" do
    assert @group.valid?
  end

end
