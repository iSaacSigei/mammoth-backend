Rails.application.routes.draw do
  resources :profiles
  resources :users
  resources :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'confirm_account', to: 'users#confirm_account'

end
