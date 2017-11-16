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
   
    @notification = Notification.new(notification_params)
    @notification.date = Time.now
    @notification.first_name = current_user.first_name
    # Get the group, using the group id from the form
    # Associate each user in the group with the notification.
    
          

    if @notification.save
      flash[:success] = "Notification created!"
      redirect_to notifications_url
    else
      render 'new'
    end
  end

  def edit
    @notification = Notification.find(params[:id])
  end

  def destroy
    Notification.find(params[:id]).destroy
    flash[:success] = "Notification deleted"
    redirect_to notifications_url
  end 

  private

    def notification_params
      params.require(:notification).permit(:title, :first_name, :content, :group_id)
    end
end
