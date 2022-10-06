Rails.application.routes.draw do
  devise_for :users

  root "menus#index"
  resources :categories do
    resources :items
  end
  resources :orders
  resources :order_items
end
