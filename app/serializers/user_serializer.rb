class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :weather_forecast

  def weather_forecast
    self.object.weather_forecasts[-1]
  end
end
