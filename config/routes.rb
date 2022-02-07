Rails.application.routes.draw do
  devise_for :users

  resources :posts, only: [:show, :index, :new, :create]

  root "posts#index"
end
