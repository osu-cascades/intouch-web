Rails.application.routes.draw do
<<<<<<< HEAD
  get 'sessions/new'
=======
  get 'notifications/new'
>>>>>>> development

  root 'static_pages#login'
  # old way 'static_pages/login'
  #get  '/login' , to 'static_pages#login'
  #This new pattern routes a GET request for the URL /help to the help action in the Static Pages controller.
  #As with the rule for the root route, this creates two named routes, login_path and login_url:

  get  '/notifications' , to: 'static_pages#notifications'
  get '/users' , to: 'static_pages#users'
  get '/groups' , to: 'static_pages#groups'
  get '/users/new', to: 'users#new'
  post '/users/new', to: 'users#create'
<<<<<<< HEAD
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
=======
  post '/notifications/new',  to: 'notifications#create'
>>>>>>> development
  resources :users
  resources :notifications

end
