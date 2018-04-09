Rails.application.routes.draw do
  get '/cards/search', to: 'cards#search'
  get '/decks/search', to: 'decks#search'
  post '/signup', to: 'users#create'
  post '/login', to: 'auth#create'
  get '/current_user', to: 'auth#show'
  resources :cards, only: [:show, :index]
  resources :formats, only: [:index]
  resources :decks
  resources :users, only: [:update, :create, :show]
  resources :collections
end
