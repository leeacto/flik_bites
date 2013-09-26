FinalProject::Application.routes.draw do

	root 'sessions#new'
	
	
  resources :users, only: [:index,:new,:create,:edit,:update,:destory]
  get '/users/:user', to: 'users#show'
  
  resource :accounts, only: [:update]

  resources :sessions, only: [:create]
  get '/login',  to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'

  get '/restaurants', to: 'restaurants#index'
  get '/restaurants/new', to: 'restaurants#new'
  get '/:restname', to: 'restaurants#show'
  get '/:restname/edit', to: 'restaurants#edit'
  
  
  resources :restaurants
  resources :dishes
end
