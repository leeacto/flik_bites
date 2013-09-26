FinalProject::Application.routes.draw do

  resources :restaurants
  get '/:restname', to: 'restaurants#show'
  get '/:restname/edit', to: 'restaurants#edit'

  
  resources :dishes
  get '/:restname/dishes', to: 'dishes#index'
  get '/:restname/:dish', to: 'dishes#show'
end
