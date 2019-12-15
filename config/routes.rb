Rails.application.routes.draw do
  devise_for :users
  # , controllers: { registrations: 'users/registrations'}
  root to: 'posts#index'
  resources :users , only: [:show, :update]
  resources :posts, only: [:index, :new, :create, :destroy, :show] do
    resources :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  put 'users/follow/:user_id' => 'users#follow'
  put 'users/unfollow/:user_id' => 'users#unfollow'

  get 'users/follow_list/:user_id' => 'users#follow_list'
  get 'users/follower_list/:user_id' => 'users#follower_list'
end
