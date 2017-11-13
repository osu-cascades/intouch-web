class AddIndexToGroupsName < ActiveRecord::Migration[5.1]
  def change
    add_index :groups, :name, unique: true
  end
end
