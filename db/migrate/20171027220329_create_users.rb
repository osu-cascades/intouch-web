class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :user_type
      t.string :username
      t.string :password
     
      t.timestamps
    end
  end
end
