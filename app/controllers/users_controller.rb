class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :index]

  def account
    if current_user.weather_forecasts.length<1 || ((((Time.now-current_user.weather_forecasts.last.created_at.localtime)/60).to_i) > 480)
      current_user.getForecast()
    end
    render json: current_user, status: :accepted
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      @user.getForecast()
      render json: {user: UserSerializer.new(@user), token: @token}, status: :created
    else
      message = @user.errors.full_messages.join(', ')
      render json: { error: 'failed to create user', message: message }, status: :not_acceptable
    end
  end

  def index
    users = User.all
    render json: users
  end

  private
  def user_params
    params.permit(:first_name, :last_name, :email, :dob, :zip_code, :password, :gender, :weight, :temp_units, :wind_units, :notifications, :time_format, :temp_preference, :desired_temp)
  end
end
