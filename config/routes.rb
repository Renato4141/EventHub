# REEMPLAZAR el archivo completo con esto:
Rails.application.routes.draw do
  root "pages#home"

  resources :events do
    member do
      patch :publish 
      patch :cancel    
    end
    resources :registrations, only: [:create, :destroy] 
    resources :reviews, only: [:create]                  
  end

  resources :users, only: [:index, :show]
  resources :categories
  resources :venues
end