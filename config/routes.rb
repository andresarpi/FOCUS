Rails.application.routes.draw do
  get '/', to: 'static_pages#home'
  
  get '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  
  resources :surveys
  resources :users


  delete '/logout',  to: 'sessions#destroy'

end
