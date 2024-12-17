class HomeController < ApplicationController
  def index
      @secrets = Secret.all
      # @show_header = true
      render
  end
end
