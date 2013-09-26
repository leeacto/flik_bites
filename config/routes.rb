FinalProject::Application.routes.draw do
	root 'sessions#new'
	
	
  resources :users, only: [:index,:new,:create,:edit,:update,:destory]
  get '/users/:user', to: 'users#show'
  
  resource :accounts, only: [:update]

  resources :sessions, only: [:create]
  get '/login',  to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  
end
