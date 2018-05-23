class UsersController < ApplicationController
 before_action :authenticate_user!
  

  def index
    @users = User.order("lower(first_name) ASC").all
  end

  def new
  	@user = User.new
    @roles = Role.all
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      flash[:success] = "New user created!"
      redirect_to users_path
  	else
      render "new"
  	end
  end

  def edit
    @user = User.find(params[:id])
    @roles = Role.all
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(user_params_no_password)
      flash[:success] = "User updated"
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.update_attributes(deactivated: true) #unless deactivated
    flash[:success] = "User deactivated from database"
    redirect_to users_path
  end

  

  private

    def user_params
      params.require(:user).permit(:first_name, :email, :password_confirmation, :password, :last_name, :user_type, :username, group_ids:[])
    end

    def user_params_no_password
      params.require(:user).permit(:first_name, :email, :last_name, :user_type, :username, group_ids:[])
    end

end
