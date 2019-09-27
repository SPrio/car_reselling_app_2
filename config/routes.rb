Rails.application.routes.draw do
  get 'sessions/new'
  root to: 'home#index'
  get 'users/new'
  get 'home/index'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
