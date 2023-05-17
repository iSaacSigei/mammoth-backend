class ApplicationController < ActionController::API
  include ActionController::Cookies
  
  private
  
  def current_user
    token = cookies.signed[:jwt]
    return unless token
    payload = JwtUtils.decode(token)
    User.find_by(id: payload['user_id'])
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    nil
  end

  def current_admin
    token = cookies.signed[:jwt_admin]
    return unless token
    payload = JwtUtils.decode(token)
    Admin.find_by(id: payload['admin_id'])
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    nil
  end

  def authenticate_user
    unless current_user
      render json: { error: "User must login before accessing this resource" }, status: :unauthorized
    end
  end

  def authenticate_admin
    unless current_admin
      render json: { error: "Admin must login before accessing this resource" }, status: :unauthorized
    end
  end
end
