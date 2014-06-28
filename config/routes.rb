BookStore::Application.routes.draw do
  resources :carts, only: [:show]
  resources :orders, only: [:index, :new, :create]
  resources :line_items, only: [:create, :update, :destroy]
  resources :books, only: [:index, :show]
  resources :search, only: [:index]
  resources :comments, only: [:new, :create]

  get "store/index"
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations', passwords: "passwords" }

  root 'store#index', as: 'store'
end
