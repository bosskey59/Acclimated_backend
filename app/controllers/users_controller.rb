class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def account
    current_user.getForecast()
    render json: current_user, status: :accepted
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      render json: {user: @user, jwt: @token}, status: :created
    else
      message = @user.errors.full_messages.join(', ')
      render json: { error: 'failed to create user', message: message }, status: :not_acceptable
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :dob, :zip_code, :password, :gender, :weight, :temp_units, :wind_units, :notifications, :time_format, :temp_preference, :desired_temp)
  end
end
