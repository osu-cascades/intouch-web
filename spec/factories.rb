FactoryBot.define do

  factory :user do
    username "JoeS"
    first_name "Joe"
    last_name "Shmoe"
    email "joe@gmail.com"
    password "blah1234"
    user_type "client"
  end
end