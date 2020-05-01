Rails.application.routes.draw do
  resources :item_categories
  resources :categories
  resources :items
  resources :user_lists
  resources :lists
  resources :group_users
  resources :groups
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
