FinalProject::Application.routes.draw do

	root 'sessions#new'
	mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
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
