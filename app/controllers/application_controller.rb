class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  include ToursHelper
  include ReviewsHelper
  before_action :set_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def check_user
    redirect_to login_url unless check_login && check_user_role
  end

  def check_login
    return true if logged_in?

    flash[:warning] = t("controllers.errors.requied_login")
  end

  def check_user_role
    return true unless admin?

    flash[:warning] = t("controllers.errors.only_user_role")
  end

  def build_message object, default_message
    return default_message if object.errors.empty?

    " #{object.errors.full_messages.join(', ')}"
  end
end
