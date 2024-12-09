class HomeController < ApplicationController
  def index
    puts user_signed_in?
    if user_signed_in?
      @secrets = Secret.all
      render
      puts "here"
    else
      redirect_to "/users/sign_in"
      puts 'not here'
    end
  end
end
