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
    if current_admin.present?
      @land = Land.find(params[:land_id])
      if @land.update(price: params[:price])
        # send email to user with updated land price
        UserMailer.with(user: @land.user, land: @land).send_quotation_email.deliver_now
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
