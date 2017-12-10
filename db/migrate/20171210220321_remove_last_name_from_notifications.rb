class RemoveLastNameFromNotifications < ActiveRecord::Migration[5.1]
  def change
    remove_column :notifications, :last_name, :string
  end
end
