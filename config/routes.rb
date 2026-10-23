Rails.application.routes.draw do
  post 'guest_login', to: 'sessions#guest_create', as: 'guest_login'
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root "sessions#new"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "signup", to: "users#new"
  resources :users, only: [:new, :create]

  resources :password_resets, only: [:new, :create, :edit, :update]
  resource :password, only: [:edit, :update]

  resources :folders, only: [:index, :create, :edit, :update, :destroy]

  resources :words do
    member do
      patch :pin
      patch :unpin
    end

    resources :notes, only: [:new, :create, :edit, :update, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end