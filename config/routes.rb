Rails.application.routes.draw do
  get '/', to: 'static_pages#home'
  
  get '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  get '/myprofile', to: 'users#myprofile', as: 'profile'
  
  get '/newsurvey', to: 'surveys#general_new'
  
  resources :users do
    resources :surveys
  end





end
