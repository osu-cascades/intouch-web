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
  resources :groups
  resources :notifications
  resources :users

end
