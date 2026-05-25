<<<<<<< HEAD
Rails.application.routes.draw do
  root "pages#home"

  resources :events
  resources :users, only: [:index, :show]
  resources :categories
  resources :registrations, only: [:index, :show, :create, :destroy]
  resources :reviews, only: [:index, :show, :create, :destroy]
  resources :venues
end
=======
Rails.application.routes.draw do
  root "pages#home"

  resources :events
  resources :users, only: [:index, :show]

  resources :categories
  resources :registrations, only: [:index, :show, :create, :destroy]
  resources :reviews, only: [:index, :show]
  resources :venues
end
>>>>>>> 1783023853445f7a28024f7293c4c4d0cf375521
