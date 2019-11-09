Rails.application.routes.draw do
  resources :posts, only: [:index, :new, :create, :destroy, :show]
  root to: 'posts#index'
end
