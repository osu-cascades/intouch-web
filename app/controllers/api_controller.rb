class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def authenticate
    permit_params
    username = params[:username]
    password = params[:password]
    user = User.find_for_authentication(username: username)
    if user && user.valid_password?(password)
      render html: 'authenticated: ' + username
    else
      render html: 'invalid username and/or password'
    end

  end

  def permit_params
    params.permit(:username, :password)
  end

end
