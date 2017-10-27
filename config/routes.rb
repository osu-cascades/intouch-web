Rails.application.routes.draw do
  get 'static_pages/login'

  get 'static_pages/notifications'

  get 'static_pages/users'

  get 'static_pages/groups'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#login'

end
