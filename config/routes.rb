Rails.application.routes.draw do
  root "pages#home"

  resources :users, only: [:new, :create]

  get "up" => "rails/health#show", as: :rails_health_check
end