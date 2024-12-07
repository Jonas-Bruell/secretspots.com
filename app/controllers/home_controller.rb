class HomeController < ApplicationController
  def index
    Rails.logger.debug "GOOGLE_MAPS_API_KEY: #{ENV['GOOGLE_MAPS_API_KEY']}"
  end

  def google_maps_key
    render json: { API_KEY: ENV['GOOGLE_MAPS_API_KEY'] }
  end
end
