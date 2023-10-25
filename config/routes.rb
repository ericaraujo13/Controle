Rails.application.routes.draw do
  devise_for :users
  resources :transactions
  resources :products
  resources :storages
  root 'home#index'
  resources :productions
end
