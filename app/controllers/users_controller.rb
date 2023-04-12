class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
      render json: User.all
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
        @user=User.find(params[:id])
        if @user
          @user.update(user_params)
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
        params.permit(:username, :email, :password, :password_confirmation)
      end
      
end
