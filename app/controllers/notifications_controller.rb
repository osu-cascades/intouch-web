class NotificationsController < ApplicationController

  def show
    @notification = Notification.find(params[:id])
    end

  def new
  	@notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)    # Not the final implementation!
    if @notification.save
      flash[:success] = "Notification created!"
      redirect_to @notification
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def edit
  end

  private

    def notification_params
        params.require(:notification).permit(:title, :first_name, :date,:content)
    end
end
