class NotificationsController < ApplicationController

  #before_action :logged_in_user

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
    #this will prefill each notification date with the current time
    @notification.date = Time.now
    #this is the first_name of the sender so current_user >> sending to groupX
    @notification.user_id = current_user.id


    if @notification.save
      @group = Group.where(id: params[:notification][:groups])

      #raise @group.inspect
        @group.each do |group| #gets each group individually
        @notification.groups << group #hopefully adds the single group and associate with not_grou
         @user = group.users #grabs users associated with the single group
           @user.each do |user| #grabs single user from group of users in each group
            @notification.users << user # adds the user to the notifications_users association table
            end
        end
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
      params.require(:notification).permit(:title, :groups, :content)
    end
end
