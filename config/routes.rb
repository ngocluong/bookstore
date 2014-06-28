BookStore::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'sessions', registrations: 'registrations', passwords: "passwords" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  resources :carts, only: [:show]
  resources :orders, only: [:index, :new, :create]
  resources :line_items, only: [:create, :update, :destroy]
  resources :books, only: [:index, :show]
  resources :search, only: [:index]
  resources :comments, only: [:new, :create]

  get "store/index"

  root 'store#index', as: 'store'
end