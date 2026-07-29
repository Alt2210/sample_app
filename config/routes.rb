Rails.application.routes.draw do
  scope "(:locale)", locale: /vi|ja|en/ do
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    resources :products
    get "/help", to: "static_pages#help"
    get "/home", to: "static_pages#home"
    root "static_pages#home"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/users", to: "users#index"
    resources :users
    resources :account_activations, only: :edit
  end
end
