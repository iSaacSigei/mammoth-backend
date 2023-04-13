Rails.application.routes.draw do
  resources :users, only: [:index, :create, :show, :update] do
    resources :lands, only: [:index, :create, :show, :update, :destroy]
    resource :profile, only: [:show, :create, :update]
  end
  resources :admins , only: [:index, :create, :show, :update] do
    resources :lands, only: [:index, :create, :show, :destroy]
  end

  get 'confirm_account', to: 'users#confirm_account'
  post '/login', to: 'sessions#create'
  

  post '/accept_quotation/:id', to: 'lands#accept_quotation', as: 'accept_quotation'
  patch '/admins/:admin_id/lands/:land_id', to: 'admins#update_price'
  

end
