# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).



Role.create!(name: "admin")
Role.create!(name: "client")
Role.create!(name: "staff")

case Rails.env
  when "development"
    User.create!(first_name: "admin",
            last_name: "admin",
            user_type: "admin",
            username: "admin",
            password: "password",
            email: "admin@admin.com")
    User.create!(first_name: "staff",
            last_name: "staff",
            user_type: "staff",
            username: "staff",
            password: "password",
            email: "staff@staff.com")

    User.create!(first_name: "client",
            last_name: "client",
            user_type: "client",
            username: "client",
            password: "password",
            email: "client@client.com")

    Group.create!(name: "Group1")
    Group.create!(name: "Group2")
    Group.create!(name: "Group3")

  when "production"
    User.create!(first_name:  "Charlene",
             last_name: "Weirup",
             user_type: "admin",
             username: "charlene",
             password: "abilitree",
             email: "place@holder.com")

    User.create!(first_name: "admin",
            last_name: "admin",
            user_type: "admin",
            username: "admin",
            password: "queenannesrevenge",
            email: "admin@admin.com")
end



