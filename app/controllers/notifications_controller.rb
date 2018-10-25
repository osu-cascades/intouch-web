require 'pusher'
require 'json'

Pusher.app_id = ENV['APP_ID']
Pusher.key = ENV['KEY']
Pusher.secret = ENV['SECRET']
Pusher.cluster = ENV['CLUSTER']
Pusher.logger = Rails.logger
Pusher.encrypted = ENV['ENCRYPTED']

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

    @notification.date = Time.now
   
    @notification.user_id = current_user.id

    if current_user.user_type == 'client'
      @isClient = true
    end

    if @notification.save
        # TODO need to get the id from the db

       @notification.users << current_user
       @group = Group.where(id: params[:notification][:groups])
       @recipients = []
      
        @group.each do |group| #gets each group individually
          @notification.groups << group #hopefully adds the single group and associate with notifi_group table
          @user = group.users #grabs users associated with the single group
          @user.each do |user| #grabs single user from group of users in each 
            #Don't want a notification created for the current user, because the current user is sending it
            #out to other people. 
            # if current_user.username == user.username 
            #   next
            # end
            @recipients << user #adding to the array we declared earlier @recipients = []
          end
        end
        
        # get rid of duplicates
        @recipients.uniq! { |r| r.username }

        # if the user creating notification is a client, we cycle through recipients[] and take out all clients
        # we only want to create notifications for staff members of group
        if @isClient
          @recipients.reject! { |r| r.user_type == "client" }
        end

        print "recipients: #{@recipients}"

        @recipients.each do |user|
          @notification.users << user
          send_to_ios(user.username)
          send_to_fcm(user.username)
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
    Notification.find(params[:id]).users.delete(current_user)
    flash[:success] = "Notification deleted"
    redirect_to notifications_url
  end 

  private

    def notification_params
      params.require(:notification).permit(:title, :groups, :content)
    end

    def send_to_ios(channel)
      datetime = DateTime.now

      Pusher.trigger(channel, 'new-notification', {
        title: @notification.title,
        body: @notification.content,
        from: "#{current_user.first_name} #{current_user.last_name}",
        datetime: "#{datetime}"
      })
    end

  def send_to_fcm(channel)
    require 'time'

    datetime = DateTime.now

    Pusher.trigger(channel, 'new-notification', {
      title: @notification.title,
      body: @notification.content,
      by: "#{current_user.first_name} #{current_user.last_name}",
      datetime: "#{datetime}"
    })
  end
end
