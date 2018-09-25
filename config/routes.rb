Rails.application.routes.draw do
  root 'welcome#home'

  get '/auth/facebook/callback' => 'sessions#create'

  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/account', to: 'users#show'

  get '/cart', to: 'carts#show'

  resources :recipes, only: [:show, :new, :index, :create, :edit, :update] do
    resources :ingredients
  end

  resources :ingredients, only: [:new, :edit, :create] do
    resources :recipes
  end

  resources :users

  resources :carts

end
