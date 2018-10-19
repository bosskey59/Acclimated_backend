class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :zip_code, :weather_forecast, :clothing_suggestion

  def weather_forecast
    self.object.weather_forecasts[-1]
  end

  def clothing_suggestion
    if self.object.weather_forecasts[-1] == nil || self.object.weather_forecasts[-1].clothing_suggestion == nil
      nil
    else
      self.object.weather_forecasts[-1].clothing_suggestion
    end
  end
end
