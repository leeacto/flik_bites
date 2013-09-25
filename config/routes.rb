FinalProject::Application.routes.draw do
  

  resources :sessions, only: [:new, :create, :destroy]
  get '/login',  to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
end
