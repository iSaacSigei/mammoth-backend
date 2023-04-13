class AdminsController < ApplicationController
  # before_action :require_login, except: [:new, :create]
  # before_action :set_land, only: [:update_price]

  def index
    @admins = Admin.all
    render json: @admins
  end
  
  def show
    @admin = Admin.find(params[:id])
    render json: @adminGET
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
    current_admin = current_admin()
    if current_admin.present?
      @land = Land.find(params[:land_id])
      @user = @land.user # Get the user associated with the land
      if @land.update(price: params[:price])
        # Moved the email sending code here
        UserMailer.send_quotation_email(@user, current_admin, @land).deliver_now # Pass the required arguments to the send_quotation_email method
        render json: @land
      else
        render json: { errors: @land.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: "Only admins can update land price" }, status: :unauthorized
    end
  end
  
  
  
  # def give_quotation
  #   @land = Land.find(params[:land_id])
  #   @user = @land.user
  #   @quotation = Quotation.new(admin_id: current_admin.id, land_id: @land.id, price: params[:price])
  #   if @quotation.save
  #     # send email to user with quotation details and options to accept/decline
  #     UserMailer.with(user: @user, land: @land, quotation: @quotation).quotation_email.deliver_now
  #     render json: { message: "Quotation sent successfully" }, status: :ok
  #   else
  #     render json: { errors: @quotation.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  private
  
  def admin_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
end
