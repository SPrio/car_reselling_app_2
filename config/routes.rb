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
  get '/admin/all_appointments', to: 'admin#all_appointments'
  get '/admin/manage_appointment', to: 'admin#manage_appointment'
  get '/admin/schedule_appointment', to: 'admin#schedule_appointment'
  patch '/admin/set_appointment_date', to: 'admin#set_appointment_date'
  get '/admin/reject_appointment', to: 'admin#reject_appointment'
  get '/admin/accept_appointment', to: 'admin#accept_appointment'

  resources :cities
  resources :brands
  resources :models
  resources :variants
  resources :states
  resources :kilometer_ranges
  resources :years
  resources :conditions
  # get '/users/:id/cars_index', to: 'users#car_index'
  #get '/users/cars/search', to: 'users#car_search'
  # get '/users/car_add', to: 'users#car_add'

  get '/cars/search', to: 'cars#search'
  get '/cars/detail', to: 'cars#detail'
  resources :users do
    member do
      get 'my_appointments'
      get 'manage_appointment'
      get 'schedule_appointment'
      patch 'set_appointment_date'
      get 'accept_appointment'
      get 'reject_appointment'
    end
    collection do
      get 'places'
    end
    resources :cars do 
      
      member do 
        get 'quotation'
        get 'apply_appointment'
        get 'view'
        get 'buy_request'
      
      end 
      collection do
        
      end
    end
  end 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
