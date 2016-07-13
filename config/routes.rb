Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy', as: 'logout'

  get '/signup' => 'users#new', as: 'signup'
  post '/users' => 'users#create'
  get '/users/:id' => 'users#show', as: 'user'
  get '/users/:id/edit' => 'users#edit', as: 'edit_user'
  patch '/users/:id' => 'users#update'


  get '/meetups' => 'meetups#index', as: 'meetups'
  get '/meetups/new' => 'meetups#new', as: 'new_meetup'
  post '/meetups' => 'meetups#create'
  get '/meetups/:id' => 'meetups#show', as: 'meetup'
  get '/meetups/:id/edit' => 'meetups#edit', as: 'edit_meetup'
  patch '/meetups/:id' => 'meetups#update'
  delete '/meetups/:id' => 'meetups#destroy', as: 'delete_meetup'
  post '/meetups/:id' => 'meetups#join', as: 'join_meetup'
end
