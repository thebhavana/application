Rails.application.routes.draw do
  devise_for :users # Devise routes for login/signup/logout
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  resources :articles # new, create, edit, show
  resources :users, only: [ :show, :edit, :update ]  # Allow viewing user profile, editing and updating it
  get "admin_dashboard", to: "dashboard#admin"  # Only for admin users
end

# root "articles#index"  # Root route
