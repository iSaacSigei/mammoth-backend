class SessionsController < ApplicationController
  def create_user_session
    @user = User.find_by(username: params[:username])
  
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      render json: @user
    else
      render json: { error: "Invalid email or password" }, status: :unprocessable_entity
    end
  end

  def create_admin_session
    @admin = Admin.find_by(username: params[:username])
  
    if @admin&.authenticate(params[:password])
      session[:admin_id] = @admin.id
      render json: @admin
    else
      render json: { error: "Invalid email or password" }, status: :unprocessable_entity
    end
  end
end
