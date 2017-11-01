require 'test_helper'

class UsersCreateTest < ActionDispatch::IntegrationTest
  
	test "invalid create information" do
    get users_new_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: {first_name: "",
                                        last_name: "Balach", 
                                        user_type: "admin", 
                                        username: "mikey", 
                                        password: "soccerball"}}
    end
    assert_template 'users/new'
  end

end
