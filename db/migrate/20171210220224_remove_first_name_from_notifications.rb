class RemoveFirstNameFromNotifications < ActiveRecord::Migration[5.1]
  def change
    remove_column :notifications, :first_name, :string
  end
end
