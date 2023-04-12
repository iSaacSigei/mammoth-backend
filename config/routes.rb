Rails.application.routes.draw do
  resources :users, only: [:index, :create, :show, :update] do
    resources :lands, only: [:index, :create, :show, :update, :destroy]
    resource :profile, only: [:show, :create, :update]
  end
  resources :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'confirm_account', to: 'users#confirm_account'
  post '/login', to: 'sessions#create'

end
