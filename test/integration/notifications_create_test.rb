require 'test_helper'

class NotificationsCreateTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid notification create" do
    get notifications_new_path
    assert_no_difference 'Notification.count' do
      post notifications_path, params: { notification: { title:  "",
                                         first_name: "",
                                         content: "" } }
    end
    assert_template 'notifications/new'
    #assert_select 'div#<CSS id for error explanation>'
    #assert_select 'div.<CSS class for field with error>'
  end
end
