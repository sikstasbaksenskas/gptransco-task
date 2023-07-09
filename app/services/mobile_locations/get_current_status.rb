module MobileLocations
  class GetCurrentStatus
    module Statuses
      DRIVING = :driving
      IDLE = :idle
    end

    def initialize(driver_id:)
      @driver_id = driver_id
    end

    def call
      last_mobile_location = MobileLocation.where(driver_id: driver_id).last

      return unless last_mobile_location

      return Statuses::IDLE if last_mobile_location.speed.zero?

      Statuses::DRIVING
    end

    private

    attr_reader :driver_id
  end
end
