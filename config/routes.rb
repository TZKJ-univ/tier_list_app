Rails.application.routes.draw do
  get 'tierlistitems/new'
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'static_pages#home'
  get '/help', to: 'static_pages#help', as: 'help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post 'guest_login', to: 'sessions#create_guest'
  resources :users do
    member do
      get :following, :followers
    end
  end
  # /users/1/following, /users/1/followersのURLに対応
  # following_user_path(:id), followers_user_path(:id)の名前付きルーティングに対応
  resources :users
  resources :account_activations, only: [:edit]
  ## /account_activations/:id/editがurlとして使用可能に
  ## edit_account_activation_urlが名前付きルーティングとして利用可能に
  resources :password_resets, only: %i[new create edit update]
  ## それぞれ　GET, POST, GET, PATCHに対応

  resources :microposts, only: %i[create destroy]
  ## microposts_path microposts_controller#create,
  ## micropost_path(micropost) microposts_controller#destroy ...
  ## microposts/(:id)を利用可能になる
  get '/microposts', to: 'static_pages#home'
  # #一部のブラウザにおけるエラーを回避する(micropostsにindexなんてねえんだよって感じ)
  resources :relationships, only: %i[create destroy]
  resources :tierlists, only: %i[create destroy show index new update edit] do
    resources :tierlistitems, only: %i[create destroy edit update]
  end
end
