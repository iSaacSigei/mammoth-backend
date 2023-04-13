class LandsController < ApplicationController
    def create
        @land = Land.new(land_params)
        @land.image = params[:image] # Assign the uploaded image to the image column
        if @land.save
          render json: { land: @land }
        else
          render json: { errors: @land.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      private
      
      def land_params
        params.require(:land).permit(:name, :description)
      end            
end
