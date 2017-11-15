Rails.application.routes.draw do
  
  root 'static_pages#login'

  resources :groups
  #             GET    /groups(.:format)                 groups#index
  #             POST   /groups(.:format)                 groups#create
  #  new_group  GET    /groups/new(.:format)             groups#new
  # edit_group  GET    /groups/:id/edit(.:format)        groups#edit
  #      group  GET    /groups/:id(.:format)             groups#show
  #             PATCH  /groups/:id(.:format)             groups#update
  #             PUT    /groups/:id(.:format)             groups#update
  #             DELETE /groups/:id(.:format)             groups#destroy

  # Login
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # Notifications
  resources :notifications

  # Sessions
  get 'sessions/new'

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
