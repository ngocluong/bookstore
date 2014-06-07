BookStore::Application.routes.draw do
  resources :books

  get "store/index"
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations', passwords: "passwords" }

  root 'store#index', as: 'store'
end
