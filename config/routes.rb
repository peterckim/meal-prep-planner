Rails.application.routes.draw do
  root 'welcome#home'

  get '/auth/facebook/callback' => 'sessions#create'

  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'

  resources :recipes, only: [:show, :new, :index] do
    resources :ingredients, only: [:show, :index]
  end

  resources :ingredients
end
