Rails.application.routes.draw do

  get "about", to: "about#index", as: :about
  
  get "sign_up", to: "registration#new"
  post "sign_up", to: "registration#create"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete 'logout', to: 'sessions#destroy'
  
  root to: "main#index"
end
