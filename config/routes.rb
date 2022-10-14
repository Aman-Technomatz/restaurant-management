Rails.application.routes.draw do
  devise_for :users
  get '/dashboard', to: 'orders#dashboard'
  get '/send_mail', to: 'orders#send_mail'

  root "menus#index"
  resources :categories do
    resources :items
  end
  resources :orders do
  end
  resources :order_items
end
