Rails.application.routes.draw do
  root "sessions#new"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users, only: [:new, :create]

  get 'words/index'
  get 'words/new'
  get 'words/edit'

  get "up" => "rails/health#show", as: :rails_health_check
end