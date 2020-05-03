Rails.application.routes.draw do
  resources :categories, only: [:new, :create, :edit, :update]
  resources :items, only: [:new, :create, :edit, :update, :destroy]
  resources :lists, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :groups, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]

  get '/login', to: 'auth#login'
  post '/verify', to: 'auth#verify'
  post '/logout', to: 'auth#logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
