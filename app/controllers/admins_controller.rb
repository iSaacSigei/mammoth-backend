class AdminsController < ApplicationController
    # before_action :require_login, except: [:new, :create]
  
    def index
      @admins = Admin.all
      render json: @admins
    end
    
    def show
      @admin = Admin.find(params[:id])
      render json: @admin
    end
    def create
        @user = Admin.new(admin_params)
        if @user.save
          render json: @user, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private
    def admin_params
        params.permit(:username, :email, :password, :password_confirmation)
    end
end
