Rails.application.routes.draw do
  root 'application#home'
  resources :players
  resources :users do
    resources :teams, only: [:index, :show, :new, :create]
  end

  get '/teams/:id/matchup', to: 'teams#matchup', :as => 'matchup'
  get '/auth/facebook/callback' => 'sessions#create_by_auth'

  resources :teams
  get '/players/:id/release', to: 'players#release', :as => 'release'
  patch '/players/:id/release', to: 'players#release_update', :as => 'release_update'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'

  post '/logout', to: 'sessions#destroy', as: 'logout'
  get '/search' => 'search#index', :as => 'search'
  resources :competitions
  resources :games


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
