Rails.application.routes.draw do
  devise_for :users
  # , controllers: { registrations: 'users/registrations'}
  root to: 'posts#index'
  resources :users , only: [:show, :update]
  resources :posts, only: [:index, :new, :create, :destroy, :show] do
    resources :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
