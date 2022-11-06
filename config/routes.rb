Rails.application.routes.draw do
  root "reqs#index"
  resources :reqs
  resources :req
end
