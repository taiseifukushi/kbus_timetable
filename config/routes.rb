Rails.application.routes.draw do
  root 'bus_stops#index'
  post 'search', to: 'bus_stops#search'
end
