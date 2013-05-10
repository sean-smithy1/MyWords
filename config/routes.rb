MyWords::Application.routes.draw do

  get "users/new"

  root to: 'static_pages#home'
 
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contacts', to: 'static_pages#contacts'
  
  match '/signup',  to: 'users#new'

end
