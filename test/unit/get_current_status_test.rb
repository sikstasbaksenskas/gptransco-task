require "minitest/autorun"

class GetCurrentStatusTest < ActiveSupport::TestCase
  def setup
    @driver_id = 1
  end

  test "that status is IDLE if speed is zero" do
    create_mobile_location_with_idle_status

    status = MobileLocations::GetCurrentStatus.new(driver_id: @driver_id).call

    assert_equal(status, MobileLocations::GetCurrentStatus::Statuses::IDLE)
  end

  test "that status is DRIVING if speed is more than zero" do
    create_mobile_location_with_driving_status

    status = MobileLocations::GetCurrentStatus.new(driver_id: @driver_id).call

    assert_equal(status, MobileLocations::GetCurrentStatus::Statuses::DRIVING)
  end

  test "that status is nil if there are no records in mobile locations table" do
    status = MobileLocations::GetCurrentStatus.new(driver_id: @driver_id).call

    assert_nil(status)
  end
end
