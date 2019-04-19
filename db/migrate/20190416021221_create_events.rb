class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :time
      t.string :place
      t.string :notes
      t.string :group_participants
      t.string :hosted_by

      t.timestamps
    end
  end
end
