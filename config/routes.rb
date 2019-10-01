Rails.application.routes.draw do
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
  get '/admin/dashboard', to: 'admin#dashboard'
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
