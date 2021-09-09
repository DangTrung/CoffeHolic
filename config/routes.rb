Rails.application.routes.draw do
  namespace :admin do
    get 'dash_boards/index'
  end
  mount Ckeditor::Engine => '/ckeditor'

  root to: "homepages#index"

  get "about", to: 'homepages#about'
  get "contact", to: 'homepages#contact'
  get 'categories/index/:slug', to: 'categories#index', as: 'categories'
  get 'categories/show/:id', to: 'categories#show', as: 'category'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout' ,to: "sessions#destroy"

  resources :products, only: [:show, :index]
  resources :comments, only: [:create, :destroy]
  resources :password_resets, only: [:new, :edit, :create, :update]
  resources :articles, only: [:show, :index]
  resources :order_products, only: [:create, :destroy]
  resources :check_outs, only: [:index, :update]
  resources :messages, only: [:new, :create]
  resources :users, only: [:show, :new, :create, :edit, :update] do
    member do
      get :order_history
    end
  end
  post 'quick_add', to: 'order_products#quick_add'
  get 'cart_details', to: 'order_products#show'

  namespace :admin do
    root to: 'dash_boards#index'
    resources :categories 
    resources :products
    resources :users
    resources :articles
    resources :orders
    resources :roles
  end

end
