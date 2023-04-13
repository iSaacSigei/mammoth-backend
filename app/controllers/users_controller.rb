class UsersController < ApplicationController
    # before_action :require_login, except: [:new, :create]
  
    def index
      @users = User.all
      render json: @users, include: ['lands']
    end
    
    def show
      @user = User.includes(:profile, :lands).find(params[:id])
      render json: @user.as_json(include: { profile: {}, lands: {} })
    end
    
    def create
        @user = User.new(user_params)
        @user.confirmation_token = SecureRandom.uuid
        if @user.save
          UserMailer.account_confirmation(@user).deliver_now
          render json: { message: 'User created successfully' }, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        render json: @user, include: ['profile'], status: :ok
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end
    
      # def confirm_account
      #   @user = User.find_by_confirmation_token(params[:confirmation_token])
      #   if @user
      #     @user.confirm!
      #     redirect_to login_path, notice: 'Your account has been confirmed. Please log in to continue.'
      #   else
      #     redirect_to root_path, alert: 'Invalid confirmation link.'
      #   end
      # end

      private
      def user_params
        params.permit(:username, :email, :password, :password_confirmation, profile_attributes: [:state, :city, :street_address, :avatar, :phone])
      end
      
end
