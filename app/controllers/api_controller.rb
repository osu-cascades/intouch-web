class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def auth
    permit_params_auth
    username = params[:username]
    password = params[:password]
    user = User.find_for_authentication(username: username)
    if user && user.valid_password?(password)

      # TODO get, send token

      render html: 'authenticated: ' + username
    else
      render html: 'invalid username and/or password'
    end

  end

  def push
    # TODO
    # if token valid?
    # create notification
    permit_params_auth
    username = params[:username]
    password = params[:password]
    # title = params[:title]
    # groups = params[:groups]
    # content = params[:content]
    @user = User.find_for_authentication(username: username)
    if @user && @user.valid_password?(password)
      @notification = Notification.new
      @notification.title = "title"
      @notification.content = "content"
      @notification.date = Time.now
      @notification.user_id = @user.id
      if @notification.save
        @notification.users << @user
        send_to_ios
        send_to_fcm
        render html: 'notification sent'
      else
        render html: 'error'
      end  
    end


  end

  private

    def permit_params_auth
      params.permit(:username, :password)
    end

    def permit_params_notification
      params.permit(:username, :password, :title, :groups, :content)
    end

    def send_to_ios

        require 'net/http' # needed for production environment, but not dev?
        require 'time'

        # everything updates except for the minutes
        # datetime = DateTime.now

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
                  "from": "#{@user.first_name} #{@user.last_name}",
                  "datetime": @notification.date
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
          "interests":["abilitree"],
          "fcm": {
            "notification": {
              "title": @notification.title,
              "body": @notification.content
            },
            "data": {
              "title": @notification.title,
              "body": @notification.content,
              "by": "#{@user.first_name} #{@user.last_name}",
              "datetime": @notification.date
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
