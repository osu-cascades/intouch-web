require 'test_helper'

class NotificationTest < ActiveSupport::TestCase

  def setup
    @notification = Notification.new(title: "Example Title", date: DateTime.now, content: "This is example content", user: User.new)
  end

  test "with title, date, content and user is valid" do
    assert @notification.valid?
  end

  test "without a title is invalid" do
    @notification.title = ""
    refute @notification.valid?
  end

  test "without a date is invalid" do
    @notification.date = nil
    refute @notification.valid?
  end

  test "without a content is invalid" do
    @notification.content = ""
    refute @notification.valid?
  end

  test "without a user is invalid" do
    @notification.user = nil
    refute @notification.valid?
  end

  test "title can't be blank" do
    @notification.title = " "
    refute @notification.valid?
  end

  test "content can't be blank" do
    @notification.content = " "
    refute @notification.valid?
  end

  test "has associated users" do
    assert_respond_to @notification, :users
  end

  test "has associated groups" do
    assert_respond_to @notification, :groups
  end

end
