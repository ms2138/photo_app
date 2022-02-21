Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'signin', sign_out: 'signout', sign_up: 'signup'},
             :controllers => { :registrations => :registrations }

  resources :users, only: [:show, :index, :destroy] do
    resources :posts, only: [:show, :index, :new, :create]
  end

  root "posts#index"
end
