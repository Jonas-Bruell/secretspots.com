class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Inclusion of user authorization with Pundit
  # https://www.monterail.com/blog/how-to-set-up-user-authentication-and-authorization-in-ruby-on-rails
  include Pundit::Authorization
end
