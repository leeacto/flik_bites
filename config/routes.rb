FinalProject::Application.routes.draw do
	root 'sessions#new'
  resources :users

  resources :sessions, only: [:new, :create, :destroy]
  get '/login',  to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'

end
