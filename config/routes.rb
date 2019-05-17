Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :recipes
  end
  resources :recipes, :only => [:index, :show]
  get '/auth/:provider/callback', to: 'sessions#create'
  root :to => 'static_pages#home'
end
