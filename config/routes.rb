Rails.application.routes.draw do
  
  root 'static_pages#login'

  # Groups 
  #get '/groups' , to: 'static_pages#groups'
  get '/groups', to: 'groups#show'

  # Login
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # Notifications
  get  '/notifications' , to: 'static_pages#notifications'
  post '/notifications/new',  to: 'notifications#create'
  get 'notifications/new'

  # Sessions
  get 'sessions/new'

  # Users
  get '/users' , to: 'static_pages#users'
  get '/users/new', to: 'users#new'
  get '/users/show', to: 'users#show'
  post '/users/new', to: 'users#create'

  resources :users
  resources :notifications
  resources :groups

end
