Rails.application.routes.draw do
  get 'passwords/edit'
  get 'passwords/update'
  get 'password_resets/new'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root "sessions#new"

  # ログイン関連
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # ユーザー登録
  get "signup", to: "users#new"
  resources :users, only: [:new, :create]

  # パスワード再設定用（new, create, edit, update アクションを使用）
  resources :password_resets, only: [:new, :create, :edit, :update]

  resource :password, only: [:edit, :update]

  # フォルダの CRUD（一覧、作成、編集、更新、削除）
  resources :folders, only: [:index, :create, :edit, :update, :destroy]

  # Words の CRUD
  resources :words do
    member do
      patch :pin
      patch :unpin
    end

    resources :notes, only: [:new, :create, :edit, :update, :destroy]
  end

  # Rails 標準ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check
end