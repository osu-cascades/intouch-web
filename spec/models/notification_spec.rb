require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  def setup
    @notification = Notification.new(
      title: 'Example Title', date: DateTime.now,
      content: 'This is example content', user: User.new
    )
  end

  test 'notification should be valid when title, date, content and user are
        present' do
    assert @notification.valid?
  end

  test 'notification should be invalid when title is not present' do
    @notification.title = nil
    refute @notification.valid?
  end

  test 'notification should be invalid when date is not present' do
    @notification.date = nil
    refute @notification.valid?
  end

  test 'notification should be invalid when content is not present' do
    @notification.content = nil
    refute @notification.valid?
  end

  test 'notification should be invalid when user is not present' do
    @notification.user = nil
    refute @notification.valid?
  end

  test 'notification should be invalid when title is blank' do
    @notification.title = '    '
    refute @notification.valid?
  end

  test 'notification should be invalid when date is blank' do
    @notification.date = '    '
    refute @notification.valid?
  end

  test 'notification should be invalid when content is blank' do
    @notification.content = '    '
    refute @notification.valid?
  end

  test 'has and belongs to many groups' do
    association = Notification.reflect_on_association(:groups)
    assert_same association.macro, :has_and_belongs_to_many
  end

  test 'has and belongs to many users' do
    association = Notification.reflect_on_association(:users)
    assert_same association.macro, :has_and_belongs_to_many
  end

  test 'belongs to a user' do
    association = Notification.reflect_on_association(:user)
    assert_same association.macro, :belongs_to
  end
end
