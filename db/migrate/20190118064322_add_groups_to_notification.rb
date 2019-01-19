class AddGroupsToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :group_recipients, :string, array: true, default: []
  end
end
