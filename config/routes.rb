MyWords::Application.routes.draw do

  resources :users

  resources :lists do
    resources :words, only: [:new, :create, :edit, :update]
  end

  resources :word_imports, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  root to: 'static_pages#home'

  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contacts', to: 'static_pages#contacts'
  get '/import', to: 'static_pages#import'

  get '/signup',  to: 'users#new'
  get '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

end
