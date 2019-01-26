require 'pusher-push-notifications'

class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  Pusher::PushNotifications.configure do |config|
    config.instance_id = ENV['INSTANCE_ID']
    config.secret_key = ENV['SECRET']
  end

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
      @notification.group_recipients << group

      recipients = get_recipients(group)

      if @notification.save
        recipients.each do |recipient|
          @notification.users << recipient
          send_to_mobile(recipient.username)
        end
        render html: 'notification sent'
      else
        render html: 'error creating notification'
      end
    else
      render html: 'invalid token'
    end
  end

  def get_groups
    permit_params_auth
    username = params[:username]
    password = params[:password]
    user = User.find_for_authentication(username: username)
    if user && user.valid_password?(password)
      groups = []
      Group.all.each do |group|
        groups << group.name
      end
      render json: groups
    end
  end

  def reply_to_sender
    permit_params_reply_to_sender
    username = params[:username]
    password = params[:password]
    content = params[:body]
    sender = params[:sender]
    @user = User.find_for_authentication(username: username)
    if @user && @user.valid_password?(password)
      @notification = Notification.new
      @notification.title = "Reply to sender from: #{@user.first_name} #{@user.last_name}"
      @notification.content = content
      @notification.date = DateTime.now
      @notification.user_id = @user.id
      if @notification.save
        send_to_mobile(sender)
        render html: 'notification sent'
      else
        render html: 'error creating notification'
      end
    else
      render html: 'invalid token'
    end
  end

  def reply_all
    permit_params_reply_all
    username = params[:username]
    password = params[:password]
    group_recipients = params[:group_recipients]
    content = params[:body]

    puts "#{group_recipients}, type of: #{group_recipients.class}"

    @user = User.find_for_authentication(username: username)
    if @user && @user.valid_password?(password)
      @notification = Notification.new
      @notification.title = "Reply all from: #{@user.first_name} #{@user.last_name}"
      @notification.content = content
      @notification.date = DateTime.now
      @notification.user_id = @user.id
      @notification.group_recipients = group_recipients
      if @notification.save
        group_recipients.each do |group|
          recipients = get_recipients(group)
          puts "sending to group #{group} = #{recipients}"
          recipients.each do |recipient|
            @notification.users << recipient
            puts "sending to #{recipient.username}"
            send_to_mobile(recipient.username)
          end
        end
        render html: 'notification sent'
      else
        render html: 'error creating notification'
      end
    else
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

  def permit_params_reply_to_sender
    params.permit(:username, :password, :body, :sender)
  end

  def permit_params_reply_all
    params.permit(:username, :password, :body, :group_recipients => [])
  end

  def get_recipients(group)
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
        users.each do |user|
          recipients.push(user)
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
    recipients
  end

  def send_to_mobile(channel)
    data = {
      apns: {
        aps: {
          alert: {
            title: @notification.title,
            body: @notification.content
          }
        },
        data: {
          title: @notification.title,
          body: @notification.content,
          from: "#{@user.first_name} #{@user.last_name}",
          from_username: @user.username,
          datetime: "#{@notification.date}",
          group_recipients: @notification.group_recipients
        }
      },
      fcm: {
        notification: {
          title: @notification.title,
          body: @notification.content
        },
        data: {
          title: @notification.title,
          body: @notification.content,
          sender: "#{@user.first_name} #{@user.last_name}",
          from_username: @user.username,
          datetime: "#{@notification.date}",
          group_recipients: @notification.group_recipients
        }
      }
    }

    Pusher::PushNotifications.publish(interests: [channel], payload: data)
  end
end
