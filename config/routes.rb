Rails.application.routes.draw do
  root "routes#index"
  get "search", to: "routes#search"
end
