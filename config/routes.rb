Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :users do
    get 'edit', to: 'users#edit'
  end
  root to: 'posts#ranking'
  resources :users , only: [:show, :update, :index, :edit, :destroy] do
    member do
      get 'timeline',            to: 'users#timeline'
      get 'iconedit',            to: 'users#iconedit'
      patch 'icon',              to: 'users#iconupdate'
      put 'icon',                to: 'users#iconupdate'
      get 'emailedit',           to: 'users#emailedit'
      patch 'email',             to: 'users#emailupdate'
      put 'email',               to: 'users#emailupdate'
      get 'passwordedit',        to: 'users#passwordedit'
      patch 'password',          to: 'users#passwordupdate'
      put 'password',            to: 'users#passwordupdate'
      get 'destroyconfirmation', to: 'users#destroyconfirmation'
    end
  end
  resources :rooms do
    resources :messages
  end
  resources :brands, only: [:index]
  resources :items, only: [:index, :show]
  resources :salons, only: [:show, :index]
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
