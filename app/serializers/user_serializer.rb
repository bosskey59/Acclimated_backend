class UserSerializer < ActiveModel::Serializer
  attributes :id, :zip_code, :weather_forecast, :clothing_suggestion, :first_name, :temp_units

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
