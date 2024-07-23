Rails.application.routes.draw do
  resources :users
  
  post '/auth/login', to: 'auth#login' 

  get "up" => "rails/health#show", as: :rails_health_check

end
