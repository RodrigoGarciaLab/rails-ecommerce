Rails.application.routes.draw do

  get 'orders/new'

  get 'order_items/create'
  get 'order_items/update'
  get 'order_items/destroy'
  get 'carts/show'
  get 'password_resets/new'
  get 'password_resets/edit'

  root   'static_pages#home'
  get    '/contact',           to: 'static_pages#contact'
  get    '/admin',             to: 'static_pages#admin'
  get    '/admin/products',    to: 'products#index'
  get    '/admin/users',       to: 'users#index'
  get    '/admin/orders',      to: 'orders#index'
  get    '/signup',            to: 'users#new'
  post   '/signup',            to: 'users#create'
  get    '/login',             to: 'sessions#new'
  post   '/login',             to: 'sessions#create'
  delete '/logout',            to: 'sessions#destroy'
  get    '/protein-products',  to: 'products#index_category', defaults: {category_id: 1}
  get    '/strenght-recovery', to: 'products#index_category', defaults: {category_id: 2}
  get    '/health-wellness',   to: 'products#index_category', defaults: {category_id: 3}
  get    '/all-products',      to: 'products#index_category', defaults: {category_id: 0}

  resources :orders
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :categories
  resources :products
  resource  :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
end