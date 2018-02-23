
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

      push_notification
      send_to_ios

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

    def send_to_ios

      addr = "https://9313976c-3ca4-4a1c-9538-1627280923f4.pushnotifications.pusher.com/publish_api/v1/instances/9313976c-3ca4-4a1c-9538-1627280923f4/publishes"

      uri = URI.parse(addr)

      header = {'Content-Type': 'application/json', 'Authorization': 'Bearer 638FD20E88772FEA09A6CDD6497E9A0'}
      data = {"interests":["hello"],"apns":{"aps":{"alert":{"title":"#{@notification.title}","body":"#{@notification.content}"}}}}

      # Create the HTTP objects
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, header)
      request.body = data.to_json

      # Send the request
      response = http.request(request)
    end

    # from curl-to-ruby, https://jhawthorn.github.io/curl-to-ruby/
    # def send_to_apns
    #   uri = URI.parse("https://9313976c-3ca4-4a1c-9538-1627280923f4.pushnotifications.pusher.com/publish_api/v1/instances/9313976c-3ca4-4a1c-9538-1627280923f4/publishes")
    #   request = Net::HTTP::Post.new(uri)
    #   request.content_type = "application/json"
    #   request["Authorization"] = "Bearer 638FD20E88772FEA09A6CDD6497E9A0"
    #   request.body = JSON.dump({
    #     "interests" => [
    #       "hello"
    #     ],
    #     "apns" => {
    #       "aps" => {
    #         "alert" => {
    #           "title" => "Hello",
    #           "body" => "Hello, world!"
    #         }
    #       }
    #     }
    #   })

    #   req_options = {
    #     use_ssl: uri.scheme == "https",
    #   }

    #   response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    #     http.request(request)
    #   end
    # end

end
