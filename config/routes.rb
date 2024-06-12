Rails.application.routes.draw do
  root "static_pages#home"
  get "/help", to: "static_pages#help", as: "help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :account_activations, only: [:edit]
  ## /account_activations/:id/editがurlとして使用可能に
  ## edit_account_activation_urlが名前付きルーティングとして利用可能に
end
