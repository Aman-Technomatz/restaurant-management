Rails.application.routes.draw do
  root "menus#index"
  resources :categories do
    resources :items
  end
  get 'downloads/:id', to: 'orders#download'
  get 'preview', to: 'orders#preview'
  resources :orders
  resources :order_items
end
