class RemoveNotificationUserFkConstraint < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :notifications, :users
  end
end
