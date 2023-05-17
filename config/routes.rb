Rails.application.routes.draw do
  resources :users, only: [:index, :create, :show, :update] do
    resources :lands, only: [:create, :show, :update, :destroy]
    resource :profile, only: [:show, :create, :update]
  end
  resources :admins , only: [:index, :create, :update] do
    resources :lands, only: [:index, :show, :destroy]
    resources :users, only: [:index]
  end

  post '/user_login', to: 'sessions#create_user_session'
  post '/admin_login', to: 'sessions#create_admin_session'  
  get '/user', to: "users#show"
  get '/admin', to: "admins#show"
  post '/accept_quotation/:id', to: 'lands#accept_quotation', as: 'accept_quotation'
  patch '/admins/:admin_id/lands/:land_id', to: 'admins#update_price'

  delete '/logout/user', to: 'sessions#destroy_user_session'
  delete '/logout/admin', to: 'sessions#destroy_admin_session'
end
