class AdminsController < ApplicationController
    skip_before_action :verify_authenticity_token

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
