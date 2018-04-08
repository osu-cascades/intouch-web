require 'net/http'
require 'uri'
require 'json'

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
            if current_user.username == user.username 
              next
            end
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

        @recipients.each do |user|
          @notification.users << user
        end

      #send_to_ios
      ########################
      send_to_fcm
      ########################

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



  def notification_params
    params.require(:notification).permit(:title, :groups, :content)
  end

  def send_to_ios

    require 'net/http' # needed for production environment, but not dev?
    require 'time'

    # everything updates except for the minutes
    datetime = Time.now

    addr = "https://9313976c-3ca4-4a1c-9538-1627280923f4.pushnotifications.pusher.com/publish_api/v1/instances/9313976c-3ca4-4a1c-9538-1627280923f4/publishes"

    uri = URI.parse(addr)

    header = {'Content-Type': 'application/json', 'Authorization': 'Bearer 638FD20E88772FEA09A6CDD6497E9A0'}
    data = 
    {
        "interests":["abilitree"],
        "apns": {
          "aps": {
            "alert": {
              "title":@notification.title,
              "body":@notification.content,
              "from": "#{current_user.first_name} #{current_user.last_name}",
              "datetime": "#{datetime}"
            },
            "badge":0,
            "sound":"default"
          }
        }
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = data.to_json

    response = http.request(request)
end

  def send_to_fcm
    require 'net/http' # needed for production environment, but not dev?
    require 'time'

    # everything updates except for the minutes
    datetime = DateTime.now

    addr = "https://9313976c-3ca4-4a1c-9538-1627280923f4.pushnotifications.pusher.com/publish_api/v1/instances/9313976c-3ca4-4a1c-9538-1627280923f4/publishes"

    uri = URI.parse(addr)

    header = {'Content-Type': 'application/json', 'Authorization': 'Bearer 638FD20E88772FEA09A6CDD6497E9A0'}
    
    data = 
      {
        "interests":["test_abilitree"],
        "fcm": {
          "notification": {
            "title": @notification.title,
            "body": @notification.content
          },
          "data": {
            "title": @notification.title,
            "body": @notification.content,
            "by": "#{current_user.first_name} #{current_user.last_name}",
            "datetime": "#{datetime}"
          }
        }
      }

     
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = data.to_json
    response = http.request(request)
end

end
