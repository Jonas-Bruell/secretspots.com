class HomeController < ApplicationController
  def index
      @secrets = Secret.all
      render
  end
end
