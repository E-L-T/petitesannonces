Rails.application.routes.draw do
  get '/users/login', to: 'users#login'
  get '/users/logout', to: 'users#logout'
  post '/users/login', to: 'users#check'
  resources :users
  root to: "users#index"
  get 'advertisements/:id/publish', to: 'advertisements#publish'
  resources :advertisements

end
