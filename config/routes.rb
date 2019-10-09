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
  # get '/users/:id/cars_index', to: 'users#car_index'
  get '/users/cars/search', to: 'users#car_search'
  # get '/users/car_add', to: 'users#car_add'
  resources :users do
    member do
      get 'my_appointments'
    end
    collection do
      get 'places'
    end
    resources :cars do 
      member do 
        get 'quotation'
        get 'apply_appointment'
      end 
      collection do
        get 'search'
      end
    end
  end 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
