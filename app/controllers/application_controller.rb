class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  # before_action :correct_user

	def logged_in_user
      unless logged_in?
        flash[:danger] = "Access Denied"
        redirect_to login_path
      end
    end

  # def correct_user
  #   @user = User.find(params[:id])
  #   redirect_to(root_url) unless current_user?(@user)
  # end

end
