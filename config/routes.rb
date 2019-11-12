Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :users , only: [:show]
  resources :posts, only: [:index, :new, :create, :destroy, :show] do
    resources :comments, only: [:create, :destroy]
  end
end
