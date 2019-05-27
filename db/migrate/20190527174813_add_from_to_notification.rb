class AddFromToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :from, :string
    add_column :notifications, :from_username, :string
  end
end
