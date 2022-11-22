Rails.application.routes.draw do
  root "busstops#index"
  get "search", to: "busstops#search"
end
