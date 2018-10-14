# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_10_12_205920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clothing_suggestions", force: :cascade do |t|
    t.integer "weather_forecast_id"
    t.string "item_1"
    t.string "item_2"
    t.string "accessory_1"
    t.string "accessory_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "dob"
    t.integer "zip_code"
    t.string "password_digest"
    t.string "gender"
    t.integer "weight"
    t.string "temp_units"
    t.string "wind_units"
    t.boolean "notifications"
    t.string "time_format"
    t.string "temp_preference"
    t.string "desired_temp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weather_forecasts", force: :cascade do |t|
    t.float "percip_probability"
    t.string "percip_range"
    t.integer "temp_lo"
    t.integer "temp_hi"
    t.integer "avg_temp"
    t.string "summary"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
