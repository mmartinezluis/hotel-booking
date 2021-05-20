Rails.application.routes.draw do
  resources :cities, :only => [:index]
  resources :hotels, :only => [:index, :show]
  resources :reviews
  resources :reservations
  
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "hotels#index"
  get "/:hotelId", to: "hotels#show"
  get "/reserve/:hotelId/:code", to: "hotels#reserve"

end
