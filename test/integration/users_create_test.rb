require 'test_helper'

class UsersCreateTest < ActionDispatch::IntegrationTest
  
	test "invalid create information" do
    get users_new_path
    assert_no_difference 'User.count' do
      post users_new_path, params: { user: {first_name: "",
                                        last_name: "Balach", 
                                        username: "mikey",
                                        user_type: "admin",
                                        password: "soccerball"}}
    end
    assert_template 'users/new'
    assert_select 'div#<CSS id for error explanation>'
    assert_select 'div.<CSS class for field with error>'
  end

end
