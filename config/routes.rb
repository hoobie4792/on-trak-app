Rails.application.routes.draw do
  resources :categories, only: [:new, :create, :edit, :update]
 
  resources :lists, only: [:show, :new, :create, :edit, :update, :destroy] do 
    resources :items, only: [:new, :create, :edit, :update, :destroy] do 
      post '/check-item', to: 'items#check_item', as: 'check_item'
    end
    get '/update-members', to: 'lists#update_members', as: 'update_members'
    post '/update-members', to: 'lists#add_member', as: 'add_member'
    delete '/update-members', to: 'lists#remove_member', as: 'remove_member'
    post '/add-group', to: 'lists#add_group', as: 'add_group'
  end
  resources :groups, only: [:show, :new, :create, :edit, :update, :destroy] do
    post '/update-members', to: 'groups#add_member', as: 'add_member'
    delete '/update-members', to: 'groups#remove_member', as: 'remove_member'
  end 
  resources :users, param: :username, only: [:show, :new, :create, :edit, :update, :destroy] do
    get '/groups', to: 'users#groups', as: "groups"
  end 
  
  
    get '/', to: 'static#home'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  
  get '/login', to: 'auth#login'
  post '/verify', to: 'auth#verify'
  post '/logout', to: 'auth#logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
