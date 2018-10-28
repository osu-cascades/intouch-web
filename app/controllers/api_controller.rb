require 'pusher'

Pusher.app_id = ENV['APP_ID']
Pusher.key = ENV['KEY']
Pusher.secret = ENV['SECRET']
Pusher.cluster = 'us2'
Pusher.logger = Rails.logger
Pusher.encrypted = true

class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def auth
    permit_params_auth
    username = params[:username]
    password = params[:password]
    user = User.find_for_authentication(username: username)
    if user && user.valid_password?(password)

      # TODO: get, send token
      # TODO: create json object of group names to send back

      render html: 'usertype ' + user.user_type
    else
      render html: 'invalid username and/or password'
    end
  end

  def push
    # TODO: if token valid? create notification

    permit_params_push
    username = params[:username]
    password = params[:password]
    title = params[:title]
    group = params[:group]
    content = params[:body]

    @user = User.find_for_authentication(username: username)

    if @user && @user.valid_password?(password)
      @notification = Notification.new
      @notification.title = title
      @notification.content = content
      @notification.date = DateTime.now
      @notification.user_id = @user.id

      recipients = []
      case group
      when 'All'
        recipients = User.all
      when 'All Staff'
        recipients = User.all
        recipients = recipients.reject { |r| r.user_type == 'client' }
      when 'All Clients'
        recipients = User.all
        recipients = recipients.reject { |r| r.user_type != 'client' }
      else
        @group = Group.where(name: group)
        @group.each do |g|
          users = g.users
          users.each do |u|
            recipients.push(u)
          end
        end
        recipients.uniq! { |r| r.username }
      end

      # When a user sends a notification they will also receive that notificaion
      # So that their local device has a record

      add_user = true
      recipients.each do |user|
        if user.username == username
          add_user = false
          break
        end
      end

      add_user && recipients.push(@user)

      if @notification.save
        recipients.each do |r|
          puts "r: " + r.username
          @notification.users << r
          send_to_ios(r.username)
          # send_to_fcm(r.username)
        end
        # puts "notification sent"
        render html: 'notification sent'
      else
        # puts "error creating notification"
        render html: 'error creating notification'
      end
    else
      render html: 'invalid token'
    end
  end

  def allNotifications
    permit_params_auth
    username = params[:username]
    password = params[:password]
    user = User.find_for_authentication(username: username)
    if user && user.valid_password?(password)
      Notification.find_each do |notification|
        Pusher.trigger(channel, 'new-notification',
        {
          title: notification.title,
          body: notification.content,
          from: "#{user.first_name} #{user.last_name}",
          datetime: "#{notification.date}"
        })
      end
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
    Pusher.trigger(channel, 'new-notification',
    {
      title: @notification.title,
      body: @notification.content,
      from: "#{@user.first_name} #{@user.last_name}",
      datetime: "#{@notification.date}"
    })
  end

  def send_to_fcm(channel)
    Pusher.trigger(channel, 'new-notification',
    {
      title: @notification.title,
      body: @notification.content,
      from: "#{@user.first_name} #{@user.last_name}",
      datetime: "#{@notification.date}"
    })
  end
end
