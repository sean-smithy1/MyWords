MyWords::Application.routes.draw do

  resources :users

  resources :lists do
    resources :words
  end

  resources :sessions, only: [:new, :create, :destroy]
  root to: 'static_pages#home'

  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contacts', to: 'static_pages#contacts'

  get '/signup',  to: 'users#new'
  get '/signin',  to: 'sessions#new'
  get '/signout', to: 'sessions#destroy', via: :delete

end
