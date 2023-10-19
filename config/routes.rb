Rails.application.routes.draw do
  resources :products
  resources :storages
  root 'home#index'
  resources :productions
end
