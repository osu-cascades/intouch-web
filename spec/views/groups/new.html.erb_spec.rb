require 'rails_helper'

RSpec.describe 'groups/new', type: :view do
  before(:each) do
    assign(:group, Group.new(name: 'Group'))
  end

  it 'renders new group form' do
    render
    assert_select 'form[action=?][method=?]', groups_path, 'post' do
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
