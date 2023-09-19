Rails.application.routes.draw do
  get 'data/load_data'

  get 'ingredients/index'
  resources :ingredients, only: [:index]

  get 'home/index'
  resources :home, only: [:index]
  root 'home#index'

  get '/load_data', to: 'data#load_data'

  get '/recipes/search', to: 'recipes#search'

end
