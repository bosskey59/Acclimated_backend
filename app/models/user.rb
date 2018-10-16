class User < ApplicationRecord

  has_secure_password
  validates :email, uniqueness: true
  has_many :weather_forecasts

  def geocode
    @map_quest_url ="http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["map_quest_key"]}&location=#{self.zip_code}"
    map_data = RestClient.get(@map_quest_url)
    map_info = JSON.parse(map_data)
    return map_info["results"][0]["locations"][0]["latLng"].values.join(",")
  end



  def getForecast
    lat_lng = self.geocode()
    @api_url ="https://api.darksky.net/forecast/#{ENV["dark_sky_key"]}/#{lat_lng}?exclude=[minutely,daily,alerts,flags]"
    # fetch the weather for LA
    weather_data = RestClient.get(@api_url)
    weather = JSON.parse(weather_data)
    i=0
    temps=[]
    precips =[]
    precips_summary=[]
    8.times do
      temps.push(weather["hourly"]["data"][i]["temperature"])
      precips.push(weather["hourly"]["data"][i]["precipProbability"]*100)
      if weather["hourly"]["data"][i]["precipProbability"] > 0
        datetime = weather["hourly"]["data"][i]["time"]
        time = Time.strptime(datetime.to_s,'%s').strftime("%l:%M %P")
        type = weather["hourly"]["data"][i]["precipType"]
        percentage =(weather["hourly"]["data"][i]["precipProbability"]*100).round
        precips_summary.push("#{percentage}% chance of #{type} at #{time}")
      end
      i+=1
    end

    temp_hi = temps.max.round
    temp_lo = temps.min.round
    temp_avg = (temps.reduce(0, :+)/temps.length).round
    precip_avg = (precips.reduce(0, :+)/precips.length).round
    precips_summary=precips_summary.join(", ")

    WeatherForecast.create(percip_probability:precip_avg, temp_lo:temp_lo, temp_hi:temp_hi, avg_temp:temp_avg, user:self, percip_range:precips_summary)

  end
end
