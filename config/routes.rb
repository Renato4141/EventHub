Rails.application.routes.draw do
  root "pages#home"

  resources :events, only: [:index, :show]
  resources :users, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :registrations, only: [:index, :show]
  resources :reviews, only: [:index, :show]
  resources :venues
end