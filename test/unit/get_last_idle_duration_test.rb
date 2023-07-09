require "minitest/autorun"

class GetLastIdleDurationTest < ActiveSupport::TestCase
  def setup
    @driver_id = 1
  end

  test "that last idle duration, time_from and time_to are calculated correctly" do
    create_mobile_locations_test_data

    time_from, time_to, duration_in_minutes = MobileLocations::GetLastIdleDuration.new(driver_id: @driver_id).call

    assert_equal("2023-07-07 10:00:00 UTC", time_from.to_s)
    assert_equal("2023-07-07 13:00:00 UTC", time_to.to_s)
    assert_equal(180.0, duration_in_minutes)
  end

  test "that nil is returned when there are no records with idle status" do
    time_from, time_to, duration_in_minutes = MobileLocations::GetLastIdleDuration.new(driver_id: @driver_id).call

    assert_nil(time_from)
    assert_nil(time_to)
    assert_nil(duration_in_minutes)
  end

  test "that duration_in_minutes is zero when there is only one record idle status" do
    create_mobile_location_with_idle_status

    time_from, time_to, duration_in_minutes = MobileLocations::GetLastIdleDuration.new(driver_id: @driver_id).call

    assert_equal(0.0, duration_in_minutes)
  end
end
