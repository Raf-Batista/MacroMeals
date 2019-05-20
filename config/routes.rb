Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :recipes
  end

  resources :recipes do
    resources :ingredients
  end

  resources :recipes, :only => [:index, :show]
  get '/auth/:provider/callback', :to => 'sessions#create'
  get '/login', :to => 'sessions#new'
  post '/login', :to => 'sessions#create'
  get '/logout', :to => 'sessions#destroy'
  get '/ten_minute_meals', :to => 'recipes#ten_minute_meals'
  get '/max_protien', :to => 'recipes#max_protien'
  get '/max_carbs', :to => 'recipes#max_carbs'
  get '/max_fat', :to => 'recipes#max_fat'
  get '/about', :to => 'static_pages#about'
  root :to => 'static_pages#home'
end
