MyWords::Application.routes.draw do

  resources :users
  resources :lists
  
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'static_pages#home'
 
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contacts', to: 'static_pages#contacts'
  
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete



end
