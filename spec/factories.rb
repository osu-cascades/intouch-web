require 'factory_bot'

FactoryBot.define do
  factory :event do
    title { "MyString" }
    description { "MyString" }
    time { "MyString" }
    place { "MyString" }
    notes { "MyString" }
    group_participants { "MyString" }
    hosted_by { "MyString" }
  end
  factory :user do
    first_name { 'Test' }
    last_name { 'User' }
    user_type { 'admin' }
    password { 'testpassword' }
    username { 'testuser' }
  end

  factory :group do
    name { 'Test Group' }
  end

  factory :notification do
  	user {User.where(username: 'testuser').first_or_create!}
  	title { 'Test1' }
  	content { 'Test123' }
  	date { Time.now }
  end
end
