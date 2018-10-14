class CreateClothingSuggestions < ActiveRecord::Migration[5.2]
  def change
    create_table :clothing_suggestions do |t|
      t.integer :weather_forecast_id
      t.string :item_1
      t.string :item_2
      t.string :accessory_1
      t.string :accessory_2

      t.timestamps
    end
  end
end
