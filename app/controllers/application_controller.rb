class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  skip_before_action :verify_authenticity_token
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  # https://www.youtube.com/watch?v=4m64FHUrEhg

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    # I18n.locale = extract_locale || I18n.default_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ?
    parsed_locale.to_sym :
    nil
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
