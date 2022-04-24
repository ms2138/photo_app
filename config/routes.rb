Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'signin', sign_out: 'signout', sign_up: 'signup'},
             :controllers => { :registrations => :registrations }

  resources :users, only: [:show, :index, :destroy] do
    member do
      get :following, :followers
    end
    
    resources :posts do
      member do
        patch "like", to: "posts#like"
        patch "unlike", to: "posts#unlike"
      end
      resources :comments, only: [:create, :destroy], shallow: true
    end
  end

  resources :relationships, only: [:create, :destroy]

  get 'search/index'
  get 'search', to: 'search#index'

  get 'pages/about'
  get 'pages/contact'
  get 'pages/privacy'

  root "posts#index"
end
