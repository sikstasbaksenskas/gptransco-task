module MobileLocations
  class CreateMobileLocation
    def initialize(mobile_location_params)
      @mobile_location_params = mobile_location_params
    end

    def call
      response = OpenStruct.new(
        message: "Mobile location created successfully!",
        success: true
      )

      mobile_location = MobileLocation.new

      mobile_location.lat = mobile_location_params.dig(:lat)
      mobile_location.lng = mobile_location_params.dig(:lng)
      mobile_location.speed = mobile_location_params.dig(:speed)
      mobile_location.device_id = mobile_location_params.dig(:device_id)
      mobile_location.driver_id = mobile_location_params.dig(:driver_id)
      mobile_location.account_id = mobile_location_params.dig(:account_id)
      mobile_location.time_updated = mobile_location_params.dig(:time_updated).to_datetime

      mobile_location.save!

      response
    rescue StandardError => e
      response.message = e.to_s
      response.success = false

      response
    end
    
    private

    attr_reader :mobile_location_params
  end
end
