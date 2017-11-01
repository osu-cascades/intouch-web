require 'test_helper'

class UsersCreateTest < ActionDispatch::IntegrationTest
  
	test "invalid create information" do
    get users_new_path
    assert_no_difference 'User.count' do
      post users_new_path, params: { user: {first_name: "",
                                        last_name: "Ballack", 
                                        username: "mikey",
                                        user_type: "admin",
                                        password: "soccerball"}}
    end
    assert_template 'users/new'
    #assert_select 'div#<CSS id for error explanation>' ~> error
    #assert_select 'div.<CSS class for field with error>' ~> error
  end

  test "valid create user information" do
    get users_new_path
    assert_difference 'User.count', 1 do 
      post users_new_path, params: { user: {first_name: "Michael",
                                        last_name: "Ballack", 
                                        username: "mikey",
                                        user_type: "admin",
                                        password: "soccerball"}}
    end
    follow_redirect!
    assert_template 'users' # taken to static_pages/users for now
  end

end
