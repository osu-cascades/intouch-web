# Abilitree - InTouch

InTouch is a mobile and web application enabling Abilitree staff and clients to communicate through groups.

This `intouch-web` repository is for administrator operations such as managing users, groups, and notifications.

## Prerequisites
* Ruby on Rails
  * [Rails overview and installation](http://guides.rubyonrails.org/getting_started.html)
  * [Installation on MacOS](http://railsapps.github.io/installrubyonrails-mac.html)
    - Follow the directions up to `Check the Gem Manager`
    - Skip until you see the command `Install Bundler`
    - Skip until `Install Rails` section

## Version
* Ruby 2.4.1  (`ruby -v`)
* Rails 5.1.4 (`rails -v`)
* PostgreSQL 10.0 (`psql --version`)

## Database Creation
* Install PostgreSQL
  * [Installation](http://postgresapp.com/)
    - Mac users might have to `brew install postgresql` if the pg gem cannot be found

## Running the Application
* Run `git clone https://github.com/osu-cascades/intouch-web.git` in desired directory
* Run `bundle install` or `exec bundle install` inside of the cloned repository
* Run `rake db:create:all`
  * _Note: The Postgres server installed above must be running_
  * If you receive the error: `FATAL:  role "intouch" does not exist`, you must create the role using `psql -c 'create user intouch with superuser;' -U postgres`
* Run `rails db:migrate`
* Run `rails db:seed`
* Run `brew install node` or `brew reinstall node`
* Run `rails s` or `bundle exec rails s` to start the application on `http://localhost:3000/`

## Tests
* To run the tests, run `rspec`
* To view test coverage, open the `coverage/index.html` page
  * [SimpleCov documentation](https://github.com/colszowka/simplecov)

© 2019 Aaron Baker, Kyleen Gonzalez, Brad Cook, Hanna Bennett, Camron Fritz.
