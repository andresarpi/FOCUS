Rails.application.routes.draw do
  get '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  
  resources :surveys
  resources :users


  delete '/logout',  to: 'sessions#destroy'

end
