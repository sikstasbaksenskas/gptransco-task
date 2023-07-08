class MobileLocation < ApplicationRecord
  validates :lat, :lng, :speed, numericality: true
  validates :device_id, :driver_id, :account_id, numericality: { only_integer: true }
end
