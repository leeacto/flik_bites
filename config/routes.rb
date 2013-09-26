FinalProject::Application.routes.draw do
  resources :restaurants
  get '/:restname', to: 'restaurants#show'
  get '/:restname/edit', to: 'restaurants#edit'
end
