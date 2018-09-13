Rails.application.routes.draw do
  root 'welcome#home'

  get '/auth/facebook/callback' => 'sessions#create'

  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  resources :recipes, only: [:show, :new, :index, :create, :edit, :update] do
    resources :ingredients, only: [:show, :index, :edit, :update, :new]
  end

  resources :ingredients, only: [:new, :create] do
    resources :recipes
  end
  resources :users
end
