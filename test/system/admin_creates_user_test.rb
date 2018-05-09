require 'application_system_test_case'

class AdminCreatesUserTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "admin creates a valid user" do
    sign_in users(:admin)
    visit new_user_url
    # TODO
    # fill in the form
    # click the create button
    # assert the screen has a "success" message
  end

end
