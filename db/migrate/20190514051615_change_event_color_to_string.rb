class ChangeEventColorToString < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :color, :string
  end
end
