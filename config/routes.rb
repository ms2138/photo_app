Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show, :index, :destroy] do
    resources :posts, only: [:show, :index, :new, :create]
  end

  root "posts#index"
end
