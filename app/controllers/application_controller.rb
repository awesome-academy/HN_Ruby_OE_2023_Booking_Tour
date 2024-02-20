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
    redirect_to login_url unless check_login? && check_user_role?
  end

  def check_login?
    return true if logged_in?

    flash[:warning] = t("controllers.errors.required_login")
    false
  end

  def check_user_role?
    return true unless admin?

    flash[:warning] = t("controllers.errors.only_user_role")
    false
  end
end
