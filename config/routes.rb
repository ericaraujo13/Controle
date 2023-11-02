Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :transactions
  resources :products
  resources :storages
  resources :productions
  resources :finances do
    collection do 
      get :export_csv
    end
  end
end
