Rails.application.routes.draw do
  root "bus_stops#index"
  get "search", to: "bus_stops#search"
end
