class SessionsController < ApplicationController
  
  def new
  end

  def create
  	user = User.find_by(username: params[:session][:username].downcase)
  	if user && user.authenticate(params[:session][:password])

  	else
      flash.now[:danger] = 'Invalid username and/or password'
  		render 'new'
  	end

  end

  def destroy
  end


end
