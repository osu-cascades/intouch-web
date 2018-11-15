require 'rails_helper'
require 'factory_bot'

RSpec.feature 'Group management', type: :feature do
  context 'User is logged in as an admin' do
    before(:each) do
      user = FactoryBot.create(:user)
      login_as(user, scope: :user)
    end

    scenario 'User creates a new group' do
      visit 'groups'
      click_link 'Create New Group'
      fill_in 'Name', with: 'Group Name'
      click_button 'Create Group'
      expect(page).to have_text('New group created!')
    end

    scenario 'User edits a group' do
      group = FactoryBot.create(:group)
      visit edit_group_path(group)
      expect(find_field('Name').value).to eq('Test Group')
      fill_in 'Name', with: 'Edited Group'
      click_button 'Update Group'
      expect(page).to have_text('Group updated')
      expect(page).to have_css('td', text: 'Edited Group')
    end

    scenario 'User deletes a group' do
      visit 'groups'
      delete_link = find_link 'Delete'
      expect(delete_link['data-confirm']).to eq('Are you sure?')
      expect do
        click_link 'Delete'
        sleep 1
      end
        .to change(Group, :count).by(-1)
    end
  end
end
