class CreateMobileLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :mobile_locations do |t|
      t.string :gps_logeable_type, default: "Mobile_app"

      t.bigint :device_id
      t.bigint :account_id

      t.integer :driver_id
      t.integer :truck_id

      t.decimal :lat
      t.decimal :lng
      t.decimal :speed, precision: 5, scale: 1, default: 0.0
      t.decimal :heading, precision: 5, scale: 1, default: 0.0
      t.decimal :odometer, precision: 5, scale: 2, default: 0.00
      t.decimal :fuel_percents, precision: 5, scale: 2, default: 0.00
      
      t.datetime :time_updated

      t.timestamps
    end
  end
end
