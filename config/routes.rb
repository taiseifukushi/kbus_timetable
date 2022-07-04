Rails.application.routes.draw do
  root 'base_apis#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post 'search', to: 'base_apis#search'
end
