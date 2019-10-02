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
  #get '/admin/city', to: 'admin#city_index'
  #get '/admin/city/add', to: 'admin#add_city'
  #post '/admin/city/save', to: 'admin#save_city'
  resources :cities
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
