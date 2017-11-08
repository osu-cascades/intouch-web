class UsersController < ApplicationController

  # def show
  # 	@user = User.find(params[:id])
  # end

  def show
    @users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      flash[:success] = "New user created!"
      redirect_to "/users"
  	else
  		render 'new'
  	end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :user_type, :username, :password)
    end

end
