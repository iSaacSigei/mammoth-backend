class LandsController < ApplicationController
    before_action :require_login
    before_action :set_land, only: [:show, :update, :destroy, :accept_quotation, :decline_quotation]
  
    def index
      @lands = current_user.lands
      render json: @lands
    end
  
    def show
      render json: @land
    end
  
    def create
      @land = current_user.lands.build(land_params)
      if @land.save
        render json: @land, status: :created
      else
        render json: { errors: @land.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
        if current_user.role == "User"
          @land = current_user.lands.find(params[:id])
          if @land.update(land_params)
            render json: @land
          else
            render json: { errors: @land.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: "Only users can update lands" }, status: :unauthorized
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
      params.require(:land).permit(:title, :description, :price, :location)
    end
  end
  