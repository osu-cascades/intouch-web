class NotificationsController < ApplicationController

  def index
    @notifications = Notification.all
  end

  def show
    @notification = Notification.find(params[:id])
    end

  def new
  	@notification = Notification.new
  end

  def create
    #@user = User.find(params[:user_id])
    #@notification = @user.notification.create(params[:notification])
    @notification = Notification.new(notification_params)    

    if @notification.save
      flash[:success] = "Notification created!"
      #NotificationUser.create(user_id: current_user.id , notification_id: @notification.id)
      redirect_to @notification
      
    else
      render 'new'
    end
  end

  def edit
  end

  def destroy
    Notification.find(params[:id]).destroy
    flash[:success] = "Notification deleted"
    redirect_to notifications_url
  end 

  private

    def notification_params
        params.require(:notification).permit(:title, :first_name, :date,:content)
    end
end
