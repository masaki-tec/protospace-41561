Rails.application.routes.draw do
  devise_for :users
  resources :prototypes, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :comments, only: :create
  end
  root to: 'prototypes#index'
  resources :comments, only: :create
  resources :users, only: :show
end
