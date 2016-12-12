Rails.application.routes.draw do
  root to: 'catalogs#index'
  resources :authors
  resources :publishers
  resources :books
  resources :users, only: [:show, :new, :create]
end
