class AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.find_by(email: params[:email])
    #User#authenticate comes from BCrypt
    if @user && @user.authenticate(params[:password])
      # encode token comes from ApplicationController
      if @user.weather_forecasts.length<1 || ((((Time.now-@user.weather_forecasts.last.created_at.localtime)/60).to_i) > 480)
        @user.getForecast()
      end
      token = encode_token({ user_id: @user.id })
      render json: { user: UserSerializer.new(@user), token: token }, status: :accepted
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  # private
  #
  # def user_login_params
  #   # params { user: {username: 'Chandler Bing', password: 'hi' } }
  #   params.require(:user).permit(:email, :password)
  # end

end
