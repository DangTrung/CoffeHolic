Rails.application.routes.draw do

  root to: "homepages#index"

  get "about", to: 'homepages#about'
  get "contact", to: 'homepages#contact'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout' ,to: "sessions#destroy"

  resources :products, only: [:show, :index]
  resources :order_products, only: [:create, :destroy]
  resources :check_outs, only: [:index, :update]
  post 'quick_add', to: 'order_products#quick_add'
  get 'cart_details', to: 'order_products#show'

  namespace :admin do
    root to: 'dashboards#index'
  end

end
