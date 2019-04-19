require 'application_system_test_case'

class AdminCreatesNotificationTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "admin creates a valid notification" do
    sign_in users(:admin)
    visit new_notification_url
    # TODO
    # fill in the form
    fill_in "Title", with: 'Test Title'
    check 'Test Group 1'
    fill_in "Content", with: 'Test Content'
    click_on 'Create My Notification'
    expect(page).to have_content("Notification created!")

    # click the send button
    # assert the screen has a "Notification created" message
  end

end
