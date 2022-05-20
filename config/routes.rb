Rails.application.routes.draw do
  get 'recipe_food/destroy'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "recipes#show_public_recipes"
  
  resources :foods, only: %i[index create destroy]
  resources :recipes, only: %i[new create index show destroy update]
  resources :recipe_foods, only: %i[destroy create]
  get 'public_recipes', to: 'recipes#show_public_recipes'
  get 'general_shopping_list', to: 'users#index', as: 'shopping_list'
end
