require 'rails_helper'

RSpec.describe 'groups/index', type: :view do
  before(:each) do
    assign(:groups,
           [
             Group.create!(
               name: 'Name'
             ),
             Group.create!(
               name: 'Another name'
             )
           ])
  end

  it 'renders a list of groups' do
    render
    assert_select 'tr>td', text: 'Name', count: 1
    assert_select 'tr>td', text: 'Another name', count: 1
    assert_select 'td', text: 'Edit', count: 2
    assert_select 'td', text: 'Delete', count: 2
  end
end
