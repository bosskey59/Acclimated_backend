class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :dob
      t.integer :zip_code
      t.string :password_digest
      t.string :gender
      t.integer :weight
      t.string :temp_units
      t.string :wind_units
      t.boolean :notifications
      t.string :time_format
      t.string :temp_preference
      t.string :desired_temp
      t.timestamps
    end
  end
end
