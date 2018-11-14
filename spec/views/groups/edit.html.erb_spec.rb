require 'rails_helper'

RSpec.describe 'groups/edit', type: :view do
  before(:each) do
    @group = assign(:group, Group.create!(name: 'Group'))
  end

  skip 'renders the edit group form' do
    render
    assert_select 'form[action=?][method=?]', group_path(@group), 'post' do
      assert_select 'input[name=?]', 'group[name]'
    end
  end

  it 'displays a field to enter name' do
    render
    expect(rendered).to have_selector('form') do |form|
      form.should have_selector('label', for: 'name')
      form.should have_selector('input', type: 'text', name: 'name')
    end
  end
end
