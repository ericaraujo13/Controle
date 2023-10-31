Rails.application.routes.draw do
  resources :finances
  devise_for :users
  resources :transactions
  resources :products
  resources :storages
  root 'home#index'
  resources :productions
end
