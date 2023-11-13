Rails.application.routes.draw do
  root "availabilities#index"

  resources :availabilities do
    resources :requests, only: [:index] do
      member do
        post 'accept'
        post 'reject'
      end
    end
  end

  resources :requests
  devise_for :users

end
