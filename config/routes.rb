FinalProject::Application.routes.draw do

  match 'auth/:provider/callback', to: 'sessions#createoauth', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  root 'landing#index'
  
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
  resources :users

  get '/users/:user', to: 'users#show'
  
  # REVIEW(RCB): I think this should be `resources :accounts, only: [:update]` (plural)
  #   This would make the path helper `accounts_path(@account)`, the url /accounts/:id and
  #   the user id would come through in params[:id]. Using params[:format] is a gross-looking hack
  resource :accounts, only: [:update]

  resources :sessions, only: [:create]
  get '/login',  to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'

  # REVIEW(RCB): what do you get from this that you don't get from POSTing to restaurants_path?
  post '/restaurants/create', to: 'restaurants#create'
  # REVIEW(RCB): this should be a "member action" of the restaurants resource. Then a path helper
  #   of `setcoords_restaurant_path(@restaurant)` would be available and it would route to POST /restaurants/:id/setcoords
  post '/restaurants/setcoords', to: 'restaurants#setcoords'

  resources :restaurants do
    resources :dishes
  end
  get '/:restname', to: 'restaurants#show'
  get '/:restname/edit', to: 'restaurants#edit'
  get '/:restname/desc', to: 'restaurants#desc'
  get '/:restname/coords', to: 'restaurants#coords'
  

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
  


end
