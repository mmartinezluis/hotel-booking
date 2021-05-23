# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  resources :cities, :only => [:index, :show]
  resources :hotels, :only => [:index, :show]
  resources :reservations, :only => [:index, :show]
  resources :reviews, :only => [:index, :show, :new, :create, :edit, :update, :delete]
  resources :users, :only =>[:new, :create, :show]
  
  root "hotels#index"
  get "/:hotelId", to: "hotels#show"
  get "/reserve/:hotelId/:code", to: "hotels#reserve"

  resources :cities, only: [:index, :show] do
    resources :hotels, only: [:index, :show]
  end

  resources :users, only: [:show] do
    resources :hotels, only: [:index]
  end

  resources :reservations, only: [:show] do
    resources :reviews, only: [:show, :new, :edit]
  end

end
