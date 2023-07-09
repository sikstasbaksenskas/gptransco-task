module MobileLocations
  class GetLastIdleDuration
    IDLE_SPEED = 0

    def initialize(driver_id:)
      @driver_id = driver_id
    end

    def call
      last_idle_mobile_location = MobileLocation.where(speed: 0).last

      return if last_idle_mobile_location.nil?

      time_to = last_idle_mobile_location.time_updated 

      last_driving_mobile_location = MobileLocation.where("time_updated < ?", last_idle_mobile_location.time_updated)
                                                   .where("speed > ?", IDLE_SPEED)
                                                   .last

      if last_driving_mobile_location
        first_idle_mobile_location = MobileLocation.where(time_updated: last_driving_mobile_location.time_updated..last_idle_mobile_location.time_updated,
                                                          speed: IDLE_SPEED).first
      else
        first_idle_mobile_location = MobileLocation.where("time_updated <= ?", last_idle_mobile_location.time_updated)
                                                   .where(speed: IDLE_SPEED)
                                                   .first
      end

      time_from = first_idle_mobile_location.time_updated

      duration_in_minutes = (time_to - time_from) / 1.minutes

      [time_from, time_to, duration_in_minutes]
    end

    private

    attr_reader :driver_id
  end
end
