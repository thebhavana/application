Rails.application.routes.draw do
  get "rooms/show"
  devise_for :admins, path: "admin"
    devise_for :users
    devise_scope :user do
    root to: "devise/sessions#new"
  end

  namespace :admin do
  get "dashboard", to: "dashboard#index"
  get "users/:id", to: "dashboard#show_user", as: :user_profile
  delete "users/:id", to: "dashboard#destroy_user", as: :delete_user
  delete "articles/:id", to: "dashboard#destroy_article", as: :delete_article
end

  resources :articles do
    resources :comments, only: [ :create, :edit, :update, :destroy ]
    post "like", to: "likes#create", on: :member  # Creaes route like#create
    post "bookmark", to: "bookmarks#create", on: :member
    # on::member - It tells rails action 'like' is for an individual record (important)
  end
  resources :users, only: [ :show, :edit, :update ]  # Path created is user_path(current_user)
  get "liked_articles", to: "articles#liked"
  get "bookmarked_articles", to: "articles#bookmarked"
  get "my_articles", to: "articles#my_articles"

  resources :rooms, only: [ :show ]
  # Mount Action Cable
  mount ActionCable.server => "/cable"
end

#  to: "likes#create" - this is important for filter
