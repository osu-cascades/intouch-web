class CreateJoinTableEventGroup < ActiveRecord::Migration[5.1]
  def change
    create_join_table :events, :groups do |t|
      t.index [:event_id, :group_id]
      t.index [:group_id, :event_id]
    end
  end
end
