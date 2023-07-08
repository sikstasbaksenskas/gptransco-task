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
end
