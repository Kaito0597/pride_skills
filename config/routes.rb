Rails.application.routes.draw do
  
  resources :users
  resources :sessions
  resources :characters
  
  get 'sessions/create'

  root "application#home"

  get '/login', controller: 'application', action: 'login', as: 'login'
  get '/logout', controller: 'sessions', action: 'destroy', as: 'logout'
  get '/register', controller: 'application', action: 'register', as: 'register'
  get '/config', controller: 'application', action: 'configuration', as: 'config'
  get '/change_char', controller: 'application', action: 'change_character', as: 'change_character'
  get '/about', controller: 'application', action: 'about', as: 'about'

end
