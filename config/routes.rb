Rails.application.routes.draw do
  resources :cities, :only => [:index, :show]
  resources :hotels, :only => [:index, :show]
  resources :reviews, :only => [:index, :show, :new, :create, :edit, :update, :delete]
  resources :reservations
  
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "hotels#index"
  get "/:hotelId", to: "hotels#show"
  get "/reserve/:hotelId/:code", to: "hotels#reserve"

  resources :cities, only: [:index, :show] do
    resources :hotels, only: [:index, :show]
  end

  resoureces :hotels, only: [:show] do
    resources :reservations, only: [:new, :show]
  end

end
