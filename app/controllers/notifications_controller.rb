
class NotificationsController < ApplicationController

  before_action :authenticate_user!, except: :messages

  def index
    @notifications = current_user.notifications
    @notifications = @notifications.reject { |n| n.user_id == current_user.id}

    @notifications_by = current_user.notifications
    @notifications_by = @notifications_by.reject { |n| n.user_id != current_user.id }
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

    if current_user.user_type == 'client'
      @isClient = true
    end

    if @notification.save
      @notification.users << current_user
      @group = Group.where(id: params[:notification][:groups])
      @recipients = []
      #raise @group.inspect
        @group.each do |group| #gets each group individually
          @notification.groups << group #hopefully adds the single group and associate with not_grou
          @user = group.users #grabs users associated with the single group
           @user.each do |user| #grabs single user from group of users in each 
            if current_user.username == user.username 
              next
            end
            @recipients << user
           # @notification.users << user # adds the user to the notifications_users association table
          end
        end
        
        # get rid of duplicates
        @recipients.uniq! { |r| r.username }

        # if client is sending, send only to staff
        if @isClient
          @recipients.reject! { |r| r.user_type == "client" }
        end

        @recipients.each do |user|
          @notification.users << user
        end

      push_notification

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

    Notification.find(params[:id]).users.delete(current_user)
    flash[:success] = "Notification deleted"
    redirect_to notifications_url
  end 

  private

    def notification_params
      params.require(:notification).permit(:title, :groups, :content)
    end

    def push_notification
      data = "#{@notification.title}: #{@notification.content}"
      Pusher.trigger('abilitree', 'notifications', {:message => @notification.title + " - " + @notification.content})
    end

end
