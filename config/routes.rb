Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  scope "(:locale)", locale: /vi|ja|en/ do
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    get "/help", to: "static_pages#help"
    get "/home", to: "static_pages#home"
    root "static_pages#home"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/users", to: "users#index"
    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :microposts, only: %i(create destroy)
    resources :password_resets, only: %i(new create edit update)
    resources :account_activations, only: :edit
    resources :relationships, only: %i(create destroy)
  end
end
