class AddUsersToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :user_recipients, :string, array: true, default: []
  end
end
