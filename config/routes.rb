# there's a mix of hard & soft tabs in this file. Replace the hard tabs
# with softtabs

FinalProject::Application.routes.draw do

  match 'auth/:provider/callback', to: 'sessions#createouath', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
	root 'landing#index'
	
	mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
  # hahaha, which actions are you not planning on exposing for /users ??
	resources :users, only: [:index,:new,:create,:edit,:update,:destory]

  # these looks non-standard. Why not use the standard /users/:id ?
  get '/users/:user', to: 'users#show'
  
  resource :accounts, only: [:update]

  resources :sessions, only: [:create]
  get '/login',  to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'


  # What if there is a restaurant named 'photos', 'dishes' or 'login' ?
  # Root level urls like this (especially dynamic ones) are going to
  # cause pain
  get '/restaurants', to: 'restaurants#index'
  get '/restaurants/new', to: 'restaurants#new'
  get '/:restname', to: 'restaurants#show'
  get '/:restname/edit', to: 'restaurants#edit'
  get '/:restname/desc', to: 'restaurants#desc'
  

  get '/:restname/dishes', to: 'dishes#index'
  get '/:restname/dishes/new', to: 'dishes#new'
  get '/:restname/:dishname', to: 'dishes#show'
  get '/:restname/:dishname/edit', to: 'dishes#edit'
  post '/:restname/dishes', to: 'dishes#create'

  post '/:restname/:dishname', to: 'dishes#photo_new'
  
  resources :dishes, only: [:update, :destroy]


  resources :photos
  

  post '/:restname/dishes/destroy', to: 'dishes#destroy'
  
  
  resources :dishes
  
  resources :restaurants do
    resources :dishes
  end


end
