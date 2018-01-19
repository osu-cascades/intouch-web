# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!(first_name:  "Charlene",
#              last_name: "Weirup",
#              user_type: "admin",
#              username: "charlene",
#              password: "abilitree")

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

Role.create!(name: "Admin")
Role.create!(name: "Client")
Role.create!(name: "Staff")