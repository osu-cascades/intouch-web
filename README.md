# Abilitree - InTouch

InTouch is a mobile and web application enabling Abilitree staff to notify clients of meeting changes, and for clients to notify staff of cancellations. 

## Prerequisites
 * Need to install Ruby on Rails
 * The website below will give some over view of Rails Framework and installation instructions
  - http://guides.rubyonrails.org/getting_started.html
  - This website gives step-by-step instuctions on how to install ROR macOSx sierra                    http://railsapps.github.io/installrubyonrails-mac.html
    - Follow the directions up to Check the Gem Manager
    - Skip until you see the command Install Bundler
    - Skip until Install Rails section. 

## Version
 * ruby 2.4.1  (ruby -v)
 * Rails 5.1.4 (rails -v)
 * PostgreSQL 10.0 (psql --version)
 
## Database creation
 * Need to install PostgreSQL
 * The website below will give installation instructions
  - http://postgresapp.com/
    - We use the postgresapp if you are familiar postgres use whatever you are comfortable with
    - mac users might have to add brew install postgresql if the pg gem cannot be found
    

 ## Running Application 
  * git clone repository in local directory
  * bundle install or exec bundle install (make sure you are in the cloned directory)
  * rake db:create:all
  * rails db:migrate
  * rails s or bundle exec rails s


© 2017 Aaron Baker, Kyleen Gonzalez
