Rails.application.routes.draw do
  root "busstops#index"
  post "test", to: "busstops#test"
  get "search", to: "busstops#search"
  post "search", to: "busstops#route"
  get "route", to: "busstops#route"
  post "route", to: "busstops#route"
end
