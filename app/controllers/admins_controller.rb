class AdminsController < ApplicationController
  before_action :authenticate_admin, only: [:show]

  def show
    render json: current_admin, status: :ok
  end
  def create
    @user = Admin.new(admin_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def update_price
    if current_admin.nil?
      render json: { errors: "Only admins can update land price" }, status: :unauthorized
    else
      @land = Land.find(params[:land_id])
      @user = @land.user # Get the user associated with the land
      if @land.update(price: params[:price])
        # Moved the email sending code here
        UserMailer.send_quotation_email(@user, current_admin, @land).deliver_now # Pass the required arguments to the send_quotation_email method
        render json: @land
      else
        render json: { errors: @land.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
  


  private
  
  def admin_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
  def require_login
    unless current_admin
      render json: { errors: "Admin must login before updating the price" }, status: :unauthorized
    end
  end
end
