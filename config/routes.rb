Rails.application.routes.draw do
  root to: 'pages#home'

  resources :requests, only: [ :index, :new, :create, :show] do
   member do
      get 'confirm'
    end
     member do
      get 'confirm_three_months'
    end
  end
end
