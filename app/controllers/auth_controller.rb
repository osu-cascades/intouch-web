class AuthController < ApplicationController


  def authorize
    render html: 'authorized'
  end

end
