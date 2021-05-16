Rails.application.routes.draw do
  resources :reviews
  resources :reservations
  resources :hotels
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "hotels#index"
end
