require 'test_helper'

class GroupEditTest < ActionDispatch::IntegrationTest

  test "unsuccessful edit" do
    get edit_group_path(@group)
    assert_template 'groups/edit'
    patch group_path(@group), params: { group: { name:  "" } }

    assert_template 'groups/edit'
  end

end
