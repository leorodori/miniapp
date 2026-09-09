Rails.application.routes.draw do
  root "sessions#new"

  # ログイン関連
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # ユーザー登録
  resources :users, only: [:new, :create]

  # Words の CRUD
  resources :words

  # Rails 標準ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check
end