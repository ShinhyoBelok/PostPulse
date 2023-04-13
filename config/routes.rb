Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "users#index"
  delete "/users/sign_out", to: "devise/sessions#destroy"
  resources :users do
    resources :posts do
      resources :comments, :likes
    end
  end
  # api ---
  get "/api/users/:user_id/posts", to: "api/posts#api_index"
  get "/api/users/:user_id/posts/:post_id/comments", to: "api/comments#api_index"
  post "/api/users/:user_id/posts/:post_id/comments", to: "api/comments#api_create_comment"
  # api ---
  get "/users/:id", to: "users#show"
  get "/users/:user_id/posts", to: "posts#index"
  get "/users/:user_id/posts/new", to: "posts#new"
  get "/users/:user_id/posts/:id", to: "posts#show"
  post "/users/:user_id/posts/new", to: "posts#create"
  # Defines the root path route ("/")
  # root "articles#index"
end
