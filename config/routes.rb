Rails.application.routes.draw do
  resources :users
  
  post '/auth/login', to: 'auth#login' 
  post '/auth/register', to: 'auth#register'

  get "up" => "rails/health#show", as: :rails_health_check

end
