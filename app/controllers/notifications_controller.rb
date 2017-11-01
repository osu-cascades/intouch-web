class NotificationsController < ApplicationController

	def show
    @notification = Notification.find(params[:id])
    end

  def new
  end
end
