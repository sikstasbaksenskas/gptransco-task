require "minitest/autorun"

class MobileLocationsTest < ActionDispatch::IntegrationTest
  def setup
    @request_payload = {
      lat: 55.1735998,
      lng: 23.8948016,
      speed: 90,
      device_id: 1,
      driver_id: 1,
      account_id: 1,
      time_updated: "2023-07-07T17:00:00"
    }

    @auth_headers = { Authorization: http_auth() }
  end

  test "that authorization is not failing with correct credentials" do
    post webhook_mobile_locations_path, env: { "RAW_POST_DATA" => @request_payload.to_json }, headers: @auth_headers, as: :json
    
    assert_response :created
  end

  test "that authorization is failing with incorrect credentials" do
    auth_headers = { Authorization: http_auth(user: "incorrect", password: "incorrect") }

    post webhook_mobile_locations_path, env: { "RAW_POST_DATA" => @request_payload.to_json }, headers: auth_headers, as: :json
    
    assert_response :unauthorized
  end

  test "that errors are returned when webhook data is invalid" do
    request_payload = {
      lat: "a",
      lng: "b",
      speed: true,
      device_id: "c",
      driver_id: "d",
      account_id: "e",
      time_updated: "2023-07-07T17:00:00"
    }

    post webhook_mobile_locations_path, env: { "RAW_POST_DATA" => request_payload.to_json }, headers: @auth_headers, as: :json

    response_body = JSON.parse(response.body)

    assert_response :unprocessable_entity

    assert_equal(
      response_body.dig("errors"),
      "Validation failed: Lat is not a number, Lng is not a number, Speed is not a number, Device is not a number, Driver is not a number, Account is not a number"
    )
  end

  test "that mobile location is created with correct values when webhook data is valid" do
    post webhook_mobile_locations_path, env: { "RAW_POST_DATA" => @request_payload.to_json }, headers: @auth_headers, as: :json

    assert_response :created

    last_mobile_location = MobileLocation.last

    assert_equal(last_mobile_location.lat, 55.1735998)
    assert_equal(last_mobile_location.lng, 23.8948016)
    assert_equal(last_mobile_location.speed, 90)
    assert_equal(last_mobile_location.device_id, 1)
    assert_equal(last_mobile_location.driver_id, 1)
    assert_equal(last_mobile_location.account_id, 1)
    assert_equal(last_mobile_location.time_updated, "2023-07-07T17:00:00")
  end
end
