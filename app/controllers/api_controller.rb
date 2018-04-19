class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def auth
    permit_params_auth
    username = params[:username]
    password = params[:password]
    user = User.find_for_authentication(username: username)
    if user && user.valid_password?(password)

      # TODO get, send token
      # TODO create json object of group names to send back

      render html: 'usertype ' + user.user_type
    else
      render html: 'invalid username and/or password'
    end

  end

  def push
    # TODO
    # if token valid?
    
    # create notification
    permit_params_push
    username = params[:username]
    password = params[:password]
    title = params[:title]
    group = params[:group]
    content = params[:body]
    # puts 'username: ' + username
    # puts 'title: ' + title
    # puts 'group: ' + group

    @user = User.find_for_authentication(username: username)
    #puts "@user: #{@user.username}"

    if @user && @user.valid_password?(password)
      @notification = Notification.new
      @notification.title = title
      @notification.content = content
      @notification.date = DateTime.now
      @notification.user_id = @user.id

      recipients = []
      case group
      when 'All'
        #puts 'Case all'
        recipients = User.all
      when 'All Staff'
        #puts 'All Staff'
        recipients = User.all
        recipients = recipients.reject {|r| r.user_type == 'client'} 
      when 'All Clients'
        #puts 'All Clients'
        recipients = User.all
        recipients = recipients.reject {|r| r.user_type != 'client'}
      else
        #puts 'case: Else'
        @group = Group.where(name: group)
        @group.each do |g|
          #puts "group name: #{g.name}"
          users = g.users
          users.each do |u|
            recipients.push(u)
          end
        end
        recipients.uniq! { |r| r.username }
      end
      
      # recipients.each do |r|
      #   puts "recipient: #{r.username}"
      # end

      # for now (4-7-18), when a user sends a notification they will also receive that notificaion so that their local device has a record
      addUser = true
      recipients.each do |user|
        if user.username == username
          addUser = false
          break
        end
      end

      #puts "addUser: #{(addUser ? "true" : "false")}"

      if addUser
        recipients.push(@user)
      end

      # puts "# recipients: #{recipients.length}"

      if @notification.save
        recipients.each do |r|
          # puts "r: " + r.username
          @notification.users << r
          send_to_ios(r.username)
          send_to_fcm(r.username)
        end
        # puts "notification sent"
        render html: 'notification sent'
      else
        # puts "error creating notification"
        render html: 'error creating notification'
      end  
    else 
      # puts "invalid token"
      render html: 'invalid token'
    end


  end

  private

    def permit_params_auth
      params.permit(:username, :password)
    end

    def permit_params_push
      params.permit(:username, :password, :title, :group, :body)
    end

    def send_to_ios(channel)

        require 'net/http' # needed for production environment, but not dev?
        require 'time'

        # everything updates except for the minutes
        # datetime = DateTime.now

        addr = "https://9313976c-3ca4-4a1c-9538-1627280923f4.pushnotifications.pusher.com/publish_api/v1/instances/9313976c-3ca4-4a1c-9538-1627280923f4/publishes"

        uri = URI.parse(addr)

        header = {'Content-Type': 'application/json', 'Authorization': 'Bearer 638FD20E88772FEA09A6CDD6497E9A0'}
        
        data = 
        {
            "interests":[channel],
            "apns": {
              "aps": {
                "alert": {
                  "title": @notification.title,
                  "body": @notification.content,
                  "from": "#{@user.first_name} #{@user.last_name}",
                  "datetime": "#{@notification.date}"
                },
                "badge": 0,
                "sound": "default"
              }
            }
        }

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Post.new(uri.request_uri, header)
        request.body = data.to_json

        response = http.request(request)
      end

      def send_to_fcm(channel)
        require 'net/http' # needed for production environment, but not dev?
        require 'time'

        # everything updates except for the minutes
        #datetime = DateTime.now

        addr = "https://9313976c-3ca4-4a1c-9538-1627280923f4.pushnotifications.pusher.com/publish_api/v1/instances/9313976c-3ca4-4a1c-9538-1627280923f4/publishes"

        uri = URI.parse(addr)

        header = {'Content-Type': 'application/json', 'Authorization': 'Bearer 638FD20E88772FEA09A6CDD6497E9A0'}
        data = 
        {
          "interests":[channel],
          "fcm": {
            "notification": {
              "title": @notification.title,
              "body": @notification.content
            },
            "data": {
              "title": @notification.title,
              "body": @notification.content,
              "by": "#{@user.first_name} #{@user.last_name}",
              "datetime": "#{@notification.date}"
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
