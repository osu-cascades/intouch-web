class AddColorToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :color, :integer
  end
end
