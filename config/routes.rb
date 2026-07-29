Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :products
  get "/help", to: "static_pages#help"
  get "/home", to: "static_pages#home"
  root "static_pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users, only: %i(new create show)
  # Defines the root path route ("/")
  # root "articles#index"
end
