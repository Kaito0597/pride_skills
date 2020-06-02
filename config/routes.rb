Rails.application.routes.draw do
  
  resources :users
  resources :sessions
  resources :games
  resources :characters
  
  get 'sessions/create'

  root "application#home"

  get '/welcome', controller: 'application', action: 'welcome', as: 'welcome'
  get '/login', controller: 'application', action: 'login', as: 'login'
  get '/logout', controller: 'sessions', action: 'destroy', as: 'logout'
  get '/register', controller: 'application', action: 'register', as: 'register'
  get '/config', controller: 'application', action: 'configuration', as: 'config'
  get '/change_char', controller: 'application', action: 'change_character', as: 'change_character'
  get '/about', controller: 'application', action: 'about', as: 'about'
  get '/date', controller: 'application', action: 'ingame_date', as: 'ingame_date'
  get '/increm_date', controller: 'games', action: 'incrementDateByOne', as: 'increment_date'
  get '/decrem_date', controller: 'games', action: 'decrementDateByOne', as: 'decrement_date'
  get '/change_date', controller: 'games', action: 'changeDate', as: 'change_date'
  get '/join_game', controller: 'games', action: 'joinGame', as: 'join_game'
  get '/settings', controller: 'users', action: 'settings', as: 'user_settings'
  get '/change_game', controller: 'games', action: 'change_game', as: 'change_game'

end
