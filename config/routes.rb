Rails.application.routes.draw do
  root "availabilities#index"
  resources :availabilities
  resources :availabilities do
    resources :requests, only: [:index]
  end
  resources :requests
  devise_for :users


end
