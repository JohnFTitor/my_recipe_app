Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "recipes#show_public_recipes"
  
  resources :foods, only: %i[index create destroy]
  resources :recipes, only: %i[new create index show destroy]
  get 'public_recipes', to: 'recipes#show_public_recipes'
end
