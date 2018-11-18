require 'rails_helper'
require 'factory_bot'

RSpec.feature 'Notifications management', type: :feature do
  context 'User is logged in as an admin' do
    before(:each) do
      user = FactoryBot.create(:user)
      login_as(user, scope: :user)
    end

    scenario 'User creates a new notification' do
      visit 'notifications'
      click_link 'Create New Notification'
      fill_in 'Title', with: 'New Notification'
      check 'Group1'
      fill_in 'Content', with: 'Test Content'
      click_link 'Create My Notification'
      expect(page).to have_text('Notification created!')
    end

    scenario 'User views a notification' do
      notification = FactoryBot.create(:notification)
      visit notification_path(notification)
      expect(page).to have_text('Test1')
      expect(page).to have_text('Test123')
    end

    scenario 'User deletes a notification' do
      notification = FactoryBot.create(:notification)
      visit 'notifications'
      delete_link = find_link 'Delete'
      expect(delete_link['data-confirm']).to eq('Are you sure?')
      expect do
        click_link 'Delete'
        sleep 1
      end
        .to change(Notification, :count).by(-1)
    end
  end
end
