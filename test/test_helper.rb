ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def http_auth(user = nil, password = nil)
    user ||= Rails.application.credentials.http_auth[:user]
    password ||= Rails.application.credentials.http_auth[:password]

    ActionController::HttpAuthentication::Basic.encode_credentials(user, password)
  end

  def create_mobile_locations_test_data
    5.times do |i|
      MobileLocation.create(
        lat: 55.1735998,
        lng: 23.8948016,
        speed: 0,
        device_id: 1,
        driver_id: 1,
        account_id: 1,
        time_updated: "2023-07-07T0#{i}:00:00"
      )
    end

    1.times do |i|
      MobileLocation.create(
        lat: 55.1735998,
        lng: 23.8948016,
        speed: 90,
        device_id: 1,
        driver_id: 1,
        account_id: 1,
        time_updated: "2023-07-07T05:00:00"
      )
    end

    3.times do |i|
      MobileLocation.create(
        lat: 55.1735998,
        lng: 23.8948016,
        speed: 0,
        device_id: 1,
        driver_id: 1,
        account_id: 1,
        time_updated: "2023-07-07T1#{i}:00:00"
      )
    end

    1.times do |i|
      MobileLocation.create(
        lat: 55.1735998,
        lng: 23.8948016,
        speed: 0,
        device_id: 1,
        driver_id: 1,
        account_id: 1,
        time_updated: "2023-07-07T13:00:00"
      )
    end
  end

  def create_mobile_location_with_idle_status
    1.times do |i|
      MobileLocation.create(
        lat: 55.1735998,
        lng: 23.8948016,
        speed: 0,
        device_id: 1,
        driver_id: 1,
        account_id: 1,
        time_updated: "2023-07-07T13:00:00"
      )
    end
  end

  def create_mobile_location_with_driving_status
    1.times do |i|
      MobileLocation.create(
        lat: 55.1735998,
        lng: 23.8948016,
        speed: 50,
        device_id: 1,
        driver_id: 1,
        account_id: 1,
        time_updated: "2023-07-07T13:00:00"
      )
    end
  end
end
