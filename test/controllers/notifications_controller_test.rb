require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    sign_in users(:admin)
  end
  test "show notifications" do
    get notifications_path
    mock_client = mock('client')
    Pusher.stub(:[]).returns()
    mock_client.should_receive( :trigger ).with( 'message', { :data => '12345' })
    assert_response :success
  end

end
