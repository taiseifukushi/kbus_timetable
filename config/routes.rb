Rails.application.routes.draw do
  root "busstops#index"
  get "search", to: "busstops#search"
  get "route", to: "busstops#route"
end
