require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
  end

  test 'successfully lists groups' do
    get groups_url
    assert_response :success
  end

  test 'redirects after creating group' do
    assert_difference('Group.count') do
      post groups_url, params: { group: { name: 'Test name' } }
    end
    assert_equal 'New group created!', flash[:success]
    assert_redirected_to groups_path
  end

  test 'redirects after editing group' do
    put group_url(Group.last), params: { group: { name: 'Updating name' } }
    assert_equal 'Group updated', flash[:success]
    assert_redirected_to groups_path
  end
end
