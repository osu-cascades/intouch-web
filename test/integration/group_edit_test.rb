require 'test_helper'

class GroupEditTest < ActionDispatch::IntegrationTest

  test "unsuccessful edit" do
    get edit_group_path(@group)
    assert_template 'groups/edit'
    patch group_path(@group), params: { group: { name:  "" } }

    assert_template 'groups/edit'
  end

  test "successful edit" do
    get edit_group_path(@user)
    assert_template 'groups/edit'
    name  = "Foo Bar"
    patch group_path(@user), params: { group: { name:  name } }
    assert_not flash.empty?
    assert_redirected_to @group
    @user.reload
    assert_equal group,  @group.name

  end

end
