class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  include ToursHelper
  before_action :set_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def check_user
    redirect_to login_url unless logged_in?
    redirect_to root_path if admin?
  end
end
