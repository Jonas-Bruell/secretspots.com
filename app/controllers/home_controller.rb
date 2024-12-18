class HomeController < ApplicationController
  def index
      @secrets = Secret.all
      @secret = Secret.new
      # @show_header = true
      render
  end
end
