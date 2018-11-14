require 'rails_helper'

RSpec.describe Notification, type: :model do
  before(:each) do
    @notification = Notification.new(
      title: 'Example Title', date: DateTime.now,
      content: 'This is example content', user: User.new
    )
  end

  it 'is valid when title, date, content and user are set' do
    expect(@notification).to be_valid
  end

  it 'is invalid when title is not present' do
    @notification.title = nil
    expect(@notification).to_not be_valid
  end

  it 'is invalid when date is not present' do
    @notification.date = nil
    expect(@notification).to_not be_valid
  end

  it 'is invalid when content is not present' do
    @notification.content = nil
    expect(@notification).to_not be_valid
  end

  it 'is invalid when user is not present' do
    @notification.user = nil
    expect(@notification).to_not be_valid
  end

  it 'is invalid when title is blank' do
    @notification.title = '    '
    expect(@notification).to_not be_valid
  end

  it 'is invalid when date is blank' do
    @notification.date = '    '
    expect(@notification).to_not be_valid
  end

  it 'is invalid when content is blank' do
    @notification.content = '    '
    expect(@notification).to_not be_valid
  end

  it 'has and belongs to many groups' do
    association = Notification.reflect_on_association(:groups)
    assert_same association.macro, :has_and_belongs_to_many
  end

  it 'has and belongs to many users' do
    association = Notification.reflect_on_association(:users)
    assert_same association.macro, :has_and_belongs_to_many
  end

  it 'belongs to a user' do
    association = Notification.reflect_on_association(:user)
    assert_same association.macro, :belongs_to
  end

  it { should validate_presence_of :title }
  it { should validate_presence_of :content }
  it { should validate_presence_of :date }
end
