Rails.application.routes.draw do
  
  get 'welcome/index'

  root to: 'welcome#index'

  # devise_for :users ....Why we commented this out explanation below. 
  #To fix problem with too many redirects the routes were the same for users and devise users.  
  #If you went to rake routes without the code below you would see that declaring
  #resources: users and devise_for :users created the same routes
  #To fix this we rename devise routes to auth. Use command rake routes to see.
  devise_for :users, :path => 'auth', controllers: {confirmations: 'confirmations'}, skip: [:registrations]
  # since we are using our own users controller to add, edit, delete users. We take out the devise registration routes
  # We will also remove the links in devise/shared/_links.html.erb that reference "sign up"
  #https://rails.devcamp.com/rails-bdd-tdd-course/install-customize-administrate-dashboard/how-to-remove-ability-users-register-devise






  resources :roles


  # Group
  resources :groups
  #             GET    /groups(.:format)                 groups#index
  #             POST   /groups(.:format)                 groups#create
  #  new_group  GET    /groups/new(.:format)             groups#new
  # edit_group  GET    /groups/:id/edit(.:format)        groups#edit
  #      group  GET    /groups/:id(.:format)             groups#show
  #             PATCH  /groups/:id(.:format)             groups#update
  #             PUT    /groups/:id(.:format)             groups#update
  #             DELETE /groups/:id(.:format)             


  # Notifications
  resources :notifications

 

  resources :users
  #           GET    /users(.:format)                  users#index
  #           POST   /users(.:format)                  users#create
  #  new_user GET    /users/new(.:format)              users#new
  # edit_user GET    /users/:id/edit(.:format)         users#edit
  #      user GET    /users/:id(.:format)              users#show
  #           PATCH  /users/:id(.:format)              users#update
  #           PUT    /users/:id(.:format)              users#update
  #           DELETE /users/:id(.:format)              users#destroy
  
end
