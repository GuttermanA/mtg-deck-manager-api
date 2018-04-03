Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cards, only: [:show, :index]
  resources :decks
  resources :users, only: [:update, :show]
  resources :collections
  post '/signup', to: 'users#create'
end
