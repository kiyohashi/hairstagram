Rails.application.routes.draw do
  devise_for :users
  # , controllers: { registrations: 'users/registrations'}
  root to: 'posts#ranking'
  resources :users , only: [:show, :update, :index] do
    member do
      get 'timeline',            to: 'users#timeline'
    end
  end
  resources :salons
  resources :posts, only: [:index, :new, :create, :destroy, :show] do
    collection do
      get 'search'
    end
    resources :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  get 'ranking',                      to: 'posts#ranking'

  put 'users/follow/:user_id',        to: 'users#follow'
  put 'users/unfollow/:user_id',      to: 'users#unfollow'
  get 'users/follow_list/:user_id',   to: 'users#follow_list'
  get 'users/follower_list/:user_id', to: 'users#follower_list'

end
