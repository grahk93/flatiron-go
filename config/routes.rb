Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static_pages#home'

  # SessionsController Routes
  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy', as: 'logout'

  # UsersController Routes
  get '/users' => 'users#index', as: 'users'
  get '/signup' => 'users#new', as: 'signup'
  post '/users' => 'users#create'
  get '/users/:id' => 'users#show', as: 'user'
  get '/users/profile/:id' => 'users#profile', as: 'profile'
  get '/users/:id/edit' => 'users#edit', as: 'edit_profile'
  patch '/users/:id' => 'users#update'

  # MeetupsController Routes
  get '/meetups' => 'meetups#index', as: 'meetups'
  get '/meetups/new' => 'meetups#new', as: 'new_meetup'
  post '/meetups' => 'meetups#create'
  get '/meetups/:id' => 'meetups#show', as: 'meetup'
  get '/meetups/:id/edit' => 'meetups#edit', as: 'edit_meetup'
  patch '/meetups/:id' => 'meetups#update'
  delete '/meetups/:id' => 'meetups#destroy', as: 'delete_meetup'
  post '/meetups/:id' => 'meetups#join', as: 'join_meetup'
  get '/dashboard' => 'meetups#dashboard', as: 'dashboard'
  get '/meetups/:id/invite' => 'meetups#invite', as: 'invite'
  post '/meetups/:id/invite' => 'meetups#create_invite'

  # CohortsController Routes
  get '/cohorts' => 'cohorts#index', as: 'cohorts'
  get '/cohorts/new' => 'cohorts#new', as: 'new_cohort'
  post '/cohorts' => 'cohorts#create'
  get '/cohorts/:id' => 'cohorts#show', as: 'cohort'
  delete '/cohorts/:id' => 'cohorts#destroy', as: 'delete_cohort'

  # LocationsController Routes
  get '/locations' => 'locations#index', as: 'locations'
  get '/locations/new' => 'locations#new', as: 'new_location'
  post '/locations' => 'locations#create'
  get '/locations/:id' => 'locations#show', as: 'location'
  delete '/cohorts/:id' => 'locations#destroy', as: 'delete_location'
end
