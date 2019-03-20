Rails.application.routes.draw do
  root to: 'pages#home'
  resources :requests, only: [ :index, :new, :create, :delete]
end
