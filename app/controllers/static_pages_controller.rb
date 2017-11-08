class StaticPagesController < ApplicationController
  #Classes are simply a convenient way to organize functions (also called methods) 
  #like the lgin and notifications actions, which are defined using the def keyword


  def login
  end

  def notifications
    @notification = Notification.order('created_at DESC')
  end

  def users
  end

  def groups
  end

end
