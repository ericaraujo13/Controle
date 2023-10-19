Rails.application.routes.draw do
  resources :transactions
  resources :products
  resources :storages
  root 'home#index'
  resources :productions
end
