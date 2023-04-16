class LandsController < ApplicationController
  before_action :set_land, only: [:show, :update, :destroy, :accept_quotation, :decline_quotation]

  def index
    if current_admin
      @lands = Land.all
      render json: @lands
    else
      render json: { errors: "You must be an admin to view this page." }, status: :unauthorized
    end
  end

  def show
    if current_admin
      render json: @land
    else
      render json: { errors: "You must be an admin to view this page." }, status: :unauthorized
    end
  end

  def create
    if current_user.nil?
      render json: { errors: "You must log in first" }, status: :unauthorized
    else
      @land = current_user.lands.build(land_params)
      if @land.save
        @land.image.attach(params[:image]) # attach the image
        render json: @land, status: :created
      else
        render json: { errors: @land.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
  
  

  def update
    @land = current_user.lands.find(params[:id])
    if @land.update(land_params)
      render json: @land
    else
      render json: { errors: @land.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user == @land.user || current_user.admin?
      @land.destroy
      head :no_content
    else
      render json: { errors: "You are not authorized to perform this action." }, status: :unauthorized
    end
  end

  def accept_quotation
    if @land.update(quotation_accepted: true)
      UserMailer.quotation_accepted_email(@land.user, @land).deliver_now
      render json: { message: "Quotation accepted successfully." }
    else
      render json: { errors: @land.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def decline_quotation
    if @land.update(quotation_accepted: false)
      UserMailer.quotation_declined_email(@land.user, @land).deliver_now
      render json: { message: "Quotation declined successfully." }
    else
      render json: { errors: @land.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_land
    @land = Land.find(params[:id])
  end

  def land_params
    params.require(:land).permit(:title, :description, :location, :street_address, :city, :state, :zipcode, :admin_id, images:[])
  end
end
