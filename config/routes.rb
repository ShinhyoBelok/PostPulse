Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "users#index"
  resources :users do
    resources :posts do
      resources :comments, :likes
    end
  end
  get "/users/:id", to: "users#show"
  get "/users/:user_id/posts", to: "posts#index"
  get "/users/:user_id/posts/new", to: "posts#new"
  get "/users/:user_id/posts/:id", to: "posts#show"
  post "/users/:user_id/posts/new", to: "posts#create"
  # Defines the root path route ("/")
  # root "articles#index"
end
