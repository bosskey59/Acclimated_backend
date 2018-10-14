class CreateWeatherForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :weather_forecasts do |t|
      t.float :percip_probability
      t.string :percip_range
      t.integer :temp_lo
      t.integer :temp_hi
      t.integer :avg_temp
      t.string :summary
      t.integer :user_id

      t.timestamps
    end
  end
end
