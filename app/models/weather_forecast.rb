class WeatherForecast < ApplicationRecord
  belongs_to :user
  has_one :clothing_suggestion


  def make_suggestion(summary)
    @string_of_accessories = self.make_precip_suggestion(summary).join(",")
    @string_of_items = self.make_temp_suggestion(summary, @string_of_accessories).join(",")
    # @string_of_accessories_1 = self.make_precip_suggestion(summary.first).join(",")
    # @string_of_items_1 = self.make_temp_suggestions(summary.first, @string_of_accessories_1).join(",")
    ClothingSuggestion.create(weather_forecast:self, item_1:@string_of_items, accessory_1:@string_of_accessories)
  end

  def make_precip_suggestion(summary)
    @accessories=[]
    @summary_with_precip = summary.select{ |y| summary[y]["precip_percentage"]!= nil}
    if @summary_with_precip.size > 0
      #decide if umbrella is needed based on type:rain || sleet
      @accessory=self.get_umbrella(@summary_with_precip)
      if (!!@accessory)
        @accessories.push(@accessory)
      end

      #decide if boots is needed based on type:snow
      @accessory=self.get_boots(@summary_with_precip)
      if (!!@accessory)
        @accessories.push(@accessory)
      end
    end

    return @accessories
  end

  # handle umbrella
  def get_umbrella(summary_with_precip)
    might_rain = summary_with_precip.select{ |y| (summary_with_precip[y]["precip_percentage"] > 50) && (summary_with_precip[y]["precip_type"] == "rain" || summary_with_precip[y]["precip_type"] == "sleet")}
      if might_rain.size > 0
        return "umbrella"
      else
        return nil
      end
  end

  # handle boots
  def get_boots(summary_with_precip)
    might_snow = summary_with_precip.select{ |y| (summary_with_precip[y]["precip_percentage"] > 50) && (summary_with_precip[y]["precip_type"] == "snow")}
      if might_snow.size > 0
        return "snow_boots"
      else
        return nil
      end
  end

  def make_temp_suggestion(summary, accessories)
    @items=[]
    ##user_multiplier will eventually be dynamic based on user sign up form
    @user_multiplier = 1
    @temp = self.temp_lo * @user_multiplier

    #jacket thresholds
    if (accessories.include?("boots") || @temp <= 50 )
      @items.push("jacket")
    #sweater thresholds
    elsif @temp > 50 && @temp <= 65
      @items.push("sweater")
    #tshirt thresholds
    elsif @temp>65 && @temp<95
      @items.push("t_shirt")
    else
      @items.push("shorts")
    end

    return @items
  end


end
