Rails.application.routes.draw do
  resources :courses do
    resources :topics do
      resources :lessons
    end
  end
  post '/courses/:id/join', to: 'courses#join'

  resources :roles
  resources :users

  post '/auth/login', to: 'application#login'
  post '/auth/register', to: 'application#register'

  get 'up' => 'rails/health#show', as: :rails_health_check
end
