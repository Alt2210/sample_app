Rails.application.routes.draw do
  resources :products
  get 'demo_partials/new'
  get 'demo_partials/edit'
  get "/help", to: "static_pages#help"
  get "/home", to: "static_pages#home"
  root "static_pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
