class AuthController < ApplicationController

  skip_before_action :verify_authenticity_token

  def authorize
    permit_params
    username = params[:username]
    password = params[:password]
    render html: 'authorized: ' + username + ' ' + password
  end

  def permit_params
    params.permit(:username, :password)
  end

end
