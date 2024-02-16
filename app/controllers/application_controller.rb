class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Admin::SecurityHelper
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
    check_login
    check_user_role
  end

  def check_login
    return if logged_in?

    flash[:warning] = t("controllers.errors.requied_login")
    redirect_to login_url
  end

  def check_user_role
    return if admin?

    flash[:warning] = t("controllers.errors.only_user_role")
    redirect_to login_url
  end
end
