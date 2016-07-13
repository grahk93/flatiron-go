Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy', as: 'logout'

  get '/users/new' => 'users#new', as: 'signup'
  post '/users' => 'users#create'
  get '/users/:id' => 'users#show', as: 'user'
  get '/users/:id/edit' => 'users#edit', as: 'edit_user'
  patch '/users/:id' => 'users#update'


  get '/meetups' => 'meetups#index'
  get '/meetups/new' => 'meetups#new'
  post '/meetups' => 'meetups#create'
  get '/meetups/:id' => 'meetups#show'
  get '/meetups/:id/edit' => 'meetups#edit'
  patch '/meetups/:id' => 'meetups#update'
  delete '/meetups/:id' => 'meetups#destroy'
end
