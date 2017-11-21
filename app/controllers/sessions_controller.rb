class SessionsController < ApplicationController
  
  def new
  end

  def create
  	user = User.find_by(username: params[:session][:username].downcase)
    # clients are not allowed access to the site at this time (11/19/2017)
    if user.user_type == 'client' 
      flash.now[:danger] = 'Invalid username and/or password'
      render 'new'
      return
    end
  	if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to notifications_path
  	else
      flash.now[:danger] = 'Invalid username and/or password'
  		render 'new'
  	end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end


end
