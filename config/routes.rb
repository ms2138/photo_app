Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'signin', sign_out: 'signout', sign_up: 'signup'},
             :controllers => { :registrations => :registrations }

  resources :users, only: [:show, :index, :destroy] do
    resources :posts do
      member do
        patch "like", to: "posts#like"
        patch "unlike", to: "posts#unlike"
      end
      resources :comments, only: [:create, :destroy], shallow: true
    end
  end

  root "posts#index"
end
