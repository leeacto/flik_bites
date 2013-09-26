FinalProject::Application.routes.draw do

  get '/restaurants', to: 'restaurants#index'
  get '/restaurants/new', to: 'restaurants#new'
  get '/:restname', to: 'restaurants#show'
  get '/:restname/edit', to: 'restaurants#edit'
  
  
  resources :restaurants
  resources :dishes
  get '/:restname/dishes', to: 'dishes#index'
  get '/:restname/:dish', to: 'dishes#show'
end
