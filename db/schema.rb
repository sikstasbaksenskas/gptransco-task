# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_08_132548) do
  create_table "mobile_locations", force: :cascade do |t|
    t.string "gps_logeable_type", default: "Mobile_app"
    t.bigint "device_id"
    t.bigint "account_id"
    t.integer "driver_id"
    t.integer "truck_id"
    t.decimal "lat"
    t.decimal "lng"
    t.decimal "speed", precision: 5, scale: 1, default: "0.0"
    t.decimal "heading", precision: 5, scale: 1, default: "0.0"
    t.decimal "odometer", precision: 5, scale: 2, default: "0.0"
    t.decimal "fuel_percents", precision: 5, scale: 2, default: "0.0"
    t.datetime "time_updated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
