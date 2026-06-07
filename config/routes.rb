Rails.application.routes.draw do
  devise_for :users

  root "pages#home"

  resources :events
  resources :categories
  resources :registrations, only: [:index, :show, :create, :destroy]
  resources :reviews, only: [:index, :show, :create, :destroy]
  resources :venues

  resources :users, only: [:index, :show], constraints: { id: /\d+/ }
end