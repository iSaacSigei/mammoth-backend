class LandsController < ApplicationController
# app/controllers/lands_controller.rb

  def create
    @land = Land.new(land_params)
    # @land.user = User.find(params[:user_id])
    # @land.admin = Admin.find(params[:admin_id])

    if @land.save
      render json: @land, status: :created
    else
      render json: { errors: @land.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def land_params
    params.require(:land).permit(:name, :description, :image)
  end
end
        
