class JoinTableGroupsNotifications < ActiveRecord::Migration[5.1]
  def change
    create_join_table :notifications, :groups do |t|
      t.index [:notification_id, :group_id]
      #t.index [:group_id, :user_id]
    end
  end
end
