class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.datetime :date
      t.text :content

      t.timestamps
    end
  end
end
