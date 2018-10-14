Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create]
  post '/login', to: 'auth#create'
  get '/account', to: 'users#account'
end
