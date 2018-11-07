require 'application_system_test_case'

class AdminCreatesUserTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "admin creates a valid user" do
    sign_in users(:admin)
    visit new_user_url
    
    
    fill_in "First Name", with: "Fake"
    fill_in "Last Name", with: "Fake"
    select('admin', :from => 'user_user_type')
    page.check("user_group_ids_1")
    fill_in "Username", with: "fakeuser"
    fill_in "Email", with:  "fake@fake.com"
    fill_in "Password", with: "fake1234"
    fill_in "Re-type Password", with: "fake1234"

    click_on "Create User"

    assert_text "New user created!"
    # TODO
    # fill in the form
    # click the create button
    # assert the screen has a "success" message
  end
end
