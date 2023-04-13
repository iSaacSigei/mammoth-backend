# Rails.application.routes.draw do
#   resources :users, only: [:index, :create, :show, :update] do
#     resources :lands, only: [:index, :create, :show, :update, :destroy]
#     resource :profile, only: [:show, :create, :update]
#   end
#   resources :admins
#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   # Defines the root path route ("/")
#   # root "articles#index"
#   get '/uploads/:model/:mounted_as/:id/:filename', to: 'images#show'
#   get 'confirm_account', to: 'users#confirm_account'
#   post '/login', to: 'sessions#create'

# end
# config/routes.rb
Rails.application.routes.draw do
  root 'lands#index' # Replace `lands#index` with the name of your own controller action
  post '/', to: 'lands#create' # Add this line to define a route for POST requests to the root URL
end
