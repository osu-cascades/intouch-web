require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
def setup
    @notification = Notification.new(title: "Example Title", first_name: "User first", last_name: "User Last", date: DateTime.now, content: "This is example content")
  end

  test "should be valid" do
    assert @notification.valid?
  end

  test "title should be present" do
    @notification.title = "     "
    assert_not @notification.valid?
  end

  test "first name should be present" do
    @notification.first_name = "     "
    assert_not @notification.valid?
  end

  test "content should be present" do
    @notification.content = "     "
    assert_not @notification.valid?
  end
end
