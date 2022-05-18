Rails.application.routes.draw do
  get 'flights/index'
  get 'flights/new'
  get 'bookings/new'
  post 'bookings/create'
  resources :bookings, only: [:create, :new, :show, :index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  root "flights#index"
end
