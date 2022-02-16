Rails.application.routes.draw do

  get "about", to: "about#index", as: :about
  
  get "sign_up", to: "registration#new"
  post "sign_up", to: "registration#create"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete 'logout', to: 'sessions#destroy'

  get 'password', to: 'passwords#edit', as: :edit_password
  patch "password", to: "passwords#update"

  get 'password/reset', to: 'password_resets#new'
  post 'password/reset', to: 'password_resets#create'

  get 'password/reset/edit', to: 'password_resets#edit'
  patch 'password/reset/edit', to: 'password_resets#update'

  get '/auth/twitter/callback', to: 'omniauth_callbacks#twitter'
  
  root to: "main#index"
end
