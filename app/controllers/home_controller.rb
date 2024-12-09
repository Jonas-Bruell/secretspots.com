class HomeController < ApplicationController
  def index
    @secrets = Secret.all
    Rails.logger.debug "DEBUG: in HOME secrets in the database : #{@secrets.inspect}"
  end
end
