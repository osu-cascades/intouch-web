require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/login'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", groups_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", notifications_path
  end
end
