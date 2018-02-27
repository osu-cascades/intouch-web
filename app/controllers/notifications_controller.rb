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

        #THis is for FCM 
        uri = URI.parse("https://420e9921-9c12-47ed-a62c-d4de75534b91.pushnotifications.pusher.com/publish_api/v1/instances/420e9921-9c12-47ed-a62c-d4de75534b91/publishes")
        request = Net::HTTP::Post.new(uri)
        request.content_type = "application/json"
        request["Authorization"] = "Bearer D998ED427143558C8DC691545174245"
        request.body = JSON.dump({
          "interests" => [
            "hello"
          ],
          "fcm" => {
            "notification" => {
              "title" => current_user.username,
              "body" => @notification.content
            }
          }
        })

      req_options = {
        use_ssl: uri.scheme == "https",
      }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    # response.code
    #  response.body
    #push_notification

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
