Rails.application.routes.draw do
  get 'brands/index'
  get 'brands/new'
  get 'brands/edit'
  get 'sessions/new'
  root to: 'home#index'
  get 'users/new'
  get 'home/index'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  get '/admin/dashboard', to: 'admin#dashboard'
  resources :cities
  resources :brands
  resources :models
  resources :variants
  resources :states
  resources :kilometer_ranges
  resources :years
  resources :conditions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
