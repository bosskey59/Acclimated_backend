require 'rest-client'
require 'json'

class User < ApplicationRecord

  has_secure_password
  validates :email, uniqueness: true


  @@api_url ="https://api.darksky.net/forecast/#{ENV["dark_sky_key"]}/37.8267,-122.4233?exclude=[minutely,daily,alerts,flags]"
  def getForecast
    # fetch the weather for LA
    weather_data = RestClient.get(@@api_url)
    weather = JSON.parse(weather_data)    
    byebug
  end
end
