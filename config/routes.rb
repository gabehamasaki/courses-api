Rails.application.routes.draw do
  resources :courses
  resources :roles
  resources :users

  post '/courses/:id/join', to: 'courses#join'
  post '/auth/login', to: 'auth#login'
  post '/auth/register', to: 'auth#register'

  get 'up' => 'rails/health#show', as: :rails_health_check
end
