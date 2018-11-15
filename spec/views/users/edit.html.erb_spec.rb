require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(first_name: 'First',
      last_name: 'Last',
      user_type: 'admin',
      password: 'password',
      username: 'testuser'))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post"
  end
end
