class MobileLocationsController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :http_basic_auth, only: :webhook

  def webhook
    response = MobileLocations::CreateMobileLocation.new(mobile_location_params).call

    if response.success
      head :created
    else
      render json: { errors: response.message }, status: :unprocessable_entity
    end
  end

  private

  def mobile_location_params
    @request_params ||= ActionController::Parameters.new(JSON.parse(request.body.read))

    @request_params.permit(:lat, :lng, :speed, :device_id, :driver_id, :account_id, :time_updated)
  end

  def http_basic_auth
    correct_user = Rails.application.credentials.http_auth[:user]
    correct_password = Rails.application.credentials.http_auth[:password]

    authenticate_or_request_with_http_basic do |user, password|
      return if user == correct_user && password == correct_password

      head :unauthorized
    end
  end
end
