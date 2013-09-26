FinalProject::Application.routes.draw do

  get '/restaurants', to: 'restaurants#index'
  get '/restaurants/new', to: 'restaurants#new'
  get '/:restname', to: 'restaurants#show'
  get '/:restname/edit', to: 'restaurants#edit'
  
  
  resources :restaurants

  get '/:restname/dishes', to: 'dishes#index'
  get '/:restname/:dishname', to: 'dishes#show'
  get '/:restname/dishes/new', to: 'dishes#new'
  get '/:restname/:dishname/edit', to: 'dishes#edit'
  put '/:restname/dishes', to: 'dishes#update'
  post '/:restname/dishes', to: 'dishes#create'

end
