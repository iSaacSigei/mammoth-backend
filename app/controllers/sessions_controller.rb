class SessionsController < ApplicationController
  require Rails.root.join('lib', 'jwt_utils')

  def create_user_session
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      token = JwtUtils.encode({ user_id: @user.id })
      @user.update(token: token)
      cookies.signed[:jwt] = { value: token, httponly: true }
      render json: @user, status: :ok
    else
      render json: { error: "Invalid username or password" }, status: :unprocessable_entity
    end
  end
  

  def create_admin_session
    @admin = Admin.find_by(username: params[:username])
  
    if @admin&.authenticate(params[:password])
      token = JwtUtils.encode({ admin_id: @admin.id })
      @admin.update(token: token)
      cookies.signed[:jwt_admin] = { value: token, httponly: true }
      render json: @admin, status: :ok
    else
      render json: { error: "Invalid username or password" }, status: :unprocessable_entity
    end
  end
  def destroy_user_session
    if current_user
      current_user.update(token: nil)
      cookies.delete(:jwt)
    end
    head :no_content
  end
  
  def destroy_admin_session
    if current_admin
      current_admin.update(token: nil)
      cookies.delete(:jwt_admin)
    end
    head :no_content
  end
  
end