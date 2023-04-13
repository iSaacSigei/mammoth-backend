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
  resources :users, only: [:index, :create, :show, :update] do
    resources :lands, only: [:index, :create, :show, :update, :destroy]
    resource :profile, only: [:show, :create, :update]
  end
  resources :admins , only: [:index, :create, :show, :update] do
    resources :lands, only: [:index, :create, :show, :destroy]
  end

  post '/login', to: 'sessions#create'
  
  post '/accept_quotation/:id', to: 'lands#accept_quotation', as: 'accept_quotation'
  patch '/admins/:admin_id/lands/:land_id', to: 'admins#update_price'
  
end
