class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :firstName
      t.string :lastName
      t.string :userType
      t.string :username
      t.string :password
     
      t.timestamps
    end
  end
end
