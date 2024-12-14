class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  skip_before_action :verify_authenticity_token
  before_action :set_locale

  # https://www.youtube.com/watch?v=4m64FHUrEhg
  I18n.default_locale = :en
  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
     # I18n.locale = extract_locale || I18n.default_locale
     I18n.locale = params[:locale] # || I18n.default_locale
     @show_header = true
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ?
    parsed_locale.to_sym :
    nil
  end
  @show_header = true # header here means the navbar, which we don't want on the login/signup page
end
