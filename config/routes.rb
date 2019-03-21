Rails.application.routes.draw do
  root to: 'pages#home'

  resources :requests, only: [ :index, :new, :create, :delete] do
   member do
      get 'confirm'
    end
     member do
      patch 'confirm_update'
    end
  end
end
