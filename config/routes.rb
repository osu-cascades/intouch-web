Rails.application.routes.draw do
  root 'static_pages#login'
  # old way 'static_pages/login'
  #get  '/login' , to 'static_pages#login'
  #This new pattern routes a GET request for the URL /help to the help action in the Static Pages controller. 
  #As with the rule for the root route, this creates two named routes, login_path and login_url:

  #get 'static_pages/notifications'
  get  '/notifications' , to: 'static_pages#notifications'
  #get 'static_pages/users'
  get '/users' , to: 'static_pages#users'
  #get 'static_pages/groups'
  get '/groups' , to: 'static_pages#groups'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  

end
