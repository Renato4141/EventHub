Rails.application.routes.draw do
  root "pages#home"

  resources :events
  resources :users, only: [:index, :show]

  resources :categories
  resources :registrations, only: [:index, :show, :create, :destroy]
  resources :reviews, only: [:index, :show]
  resources :venues
end
