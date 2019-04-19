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
    User.create!(first_name: "staff1",
            last_name: "staff1",
            user_type: "staff",
            username: "staff1",
            password: "password",
            email: "staff1@staff.com")
    User.create!(first_name: "staff2",
            last_name: "staff2",
            user_type: "staff",
            username: "staff2",
            password: "password",
            email: "staff2@staff.com")

    User.create!(first_name: "client1",
            last_name: "client1",
            user_type: "client",
            username: "client1",
            password: "password",
            email: "client1@client.com")
    User.create!(first_name: "client2",
            last_name: "client2",
            user_type: "client",
            username: "client2",
            password: "password",
            email: "client2@client.com")
    User.create!(first_name: "client3",
            last_name: "client3",
            user_type: "client",
            username: "client3",
            password: "password",
            email: "client3@client.com")

    Group.create!(name: "Group1")
    Group.create!(name: "Group2")
    Group.create!(name: "Group3")

    Event.create!(title: "Event 1",
        description: "Event 1 Description",
        time: DateTime.now,
        place: "Location 1",
        notes: "Event 1 Notes",
        group_participants: "Event 1 Groups",
        hosted_by: "Event 1 Staff")

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
            password: "abilitree",
            email: "admin@admin.com")
end



