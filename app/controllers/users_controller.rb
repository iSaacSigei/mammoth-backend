class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]
  
  def show
    render json: current_user, status: :ok
  end

  def index
    @admin = Admin.find(params[:admin_id])
    @users = @admin.users.includes(:lands)
    render json: @users.as_json(include: { lands: {} }), status: :ok
  end

  def create
    @user = User.new(user_params)
    @user.confirmation_token = SecureRandom.uuid
    if @user.save
      UserMailer.account_confirmation(@user).deliver_now
      render json: @user, status: :created
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

  private

  def user_params
    params.permit(:username, :email, :password, :token, :password_confirmation, profile_attributes: [:state, :city, :street_address, :avatar, :phone])
  end
end