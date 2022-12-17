# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  resources :cities, :only => [:index]
  resources :hotels, :only => [:index, :show]
  resources :reservations, :only => [:index, :show]
  resources :reviews, :only => [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :users, :only =>[:create, :show]
  
  # Sessions controller routes
  root 'sessions#new'
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy", as: "logout"
  get '/signup', to: 'users#new', as: 'signup'

  # Omniuath routes
  get '/auth/:provider/callback', to: 'sessions#omniauth'

  #  Amadeus API routes
  get "hotel_search", to: "hotels#index"
  get "search_results", to: "hotels#search_results"
  get "/reserve/:hotelId/:code", to: "hotels#reserve"

  # Nested routes
  resources :cities, only: [:show] do
    resources :hotels, only: [:index, :show]
  end

  resources :users, only: [:show] do
    resources :hotels, only: [:index]
  end

  resources :reservations, only: [:show] do
    resources :reviews, only: [:show, :new]
  end

  get 'trending', to: 'hotels#trending'
  get 'datalist', to: 'cities#datalist'

end
