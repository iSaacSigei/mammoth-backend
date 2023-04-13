class ProfilesController < ApplicationController
    before_action :authenticate_user
    def show
        @profile = current_user.profile
      
        if @profile
          render json: @profile, status: :ok
        else
          render json: { errors: 'Profile not found' }, status: :not_found
        end
      end
      
  
    def create
      @profile = current_user.build_profile(profile_params)
  
      if @profile.save
        render json: @profile, status: :created
      else
        render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      @profile = current_user.profile
  
      if @profile.update(profile_params)
        render json: @profile, status: :ok
      else
        render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @profile = current_user.profile
  
      if @profile.destroy
        head :no_content
      else
        render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def profile_params
      params.require(:profile).permit(:state, :city, :street_address, :avatar, :phone)
    end
  
    def authenticate_user
      head :unauthorized unless current_user
    end
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  