Rails.application.routes.draw do
  get "users/account"
  get "users/profile"
  get 'homes/top'
  get 'homes/tokyo'
  get 'homes/nagoya'
  get 'homes/osaka'
  get 'homes/hakodate'
  get 'homes/search'
  root 'homes#top'

  devise_for :users
  resources :products
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end