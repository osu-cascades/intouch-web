require 'pusher-push-notifications'
require 'json'

class NotificationsController < ApplicationController
  before_action :authenticate_user!, except: :messages

  Pusher::PushNotifications.configure do |config|
    config.instance_id = ENV['INSTANCE_ID']
    config.secret_key = ENV['SECRET']
  end

  def index
    @notifications = current_user.notifications
    @notifications = @notifications.reject { |n| n.user_id == current_user.id }

    @notifications_by = current_user.notifications
    @notifications_by = @notifications_by.select { |n| n.user_id == current_user.id }
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
    @recipients = []

    @groups = Group.where(id: params[:notification][:groups])
    @groups.each do |group|
      @notification.groups << group
      @notification.group_recipients << group.name
      @user = group.users
      @user.each do |user|
        @recipients << user
      end
    end

    @recipients.uniq!(&:username)
    @recipients.reject! { |r| r.user_type == 'client' } if current_user.user_type == 'client'

    @notification.users << current_user
    @notification.user_recipients << current_user.username
    @recipients.each do |user|
      @notification.users << user
      @notification.user_recipients << user.username
    end

    @notification.from = "#{current_user.first_name} #{current_user.last_name}"
    @notification.from_username = current_user.username

    if @notification.save
      @recipients.each do |user|
        send_to_mobile(user.username)
      end

      flash[:success] = 'Notification created!'
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
    flash[:success] = 'Notification deleted'
    redirect_to notifications_url
  end

  private

  def notification_params
    params.require(:notification).permit(:title, :content, group_recipients: [])
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
          from: @notification.from,
          from_username: @notification.from_username,
          datetime: @notification.date.to_s,
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
          sender: @notification.from,
          from_username: @notification.from_username,
          datetime: @notification.date.to_s,
          group_recipients: @notification.group_recipients
        }
      }
    }

    Pusher::PushNotifications.publish(interests: [channel], payload: data)
  end
end
