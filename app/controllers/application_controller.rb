class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization
  include ToursHelper
  include ReviewsHelper
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
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
    return true if user_signed_in?

    flash[:warning] = t("controllers.errors.requied_login")
  end

  def check_user_role
    return true unless current_user.admin?

    flash[:warning] = t("controllers.errors.only_user_role")
  end

  def build_message object, default_message
    return default_message if object.errors.empty?

    " #{object.errors.full_messages.join(', ')}"
  end

  protected

  def configure_permitted_parameters
    added_attrs = User::SIGNUP_PARAMS
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
