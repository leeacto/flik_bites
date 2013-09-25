FinalProject::Application.routes.draw do
  resources :restaurants
  get '/:restname', to: 'restaurants#show'
  # match '/:restname' => get 'restaurants#show'
end
