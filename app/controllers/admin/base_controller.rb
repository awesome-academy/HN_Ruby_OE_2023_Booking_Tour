class Admin::BaseController < ApplicationController
  layout "admin/layouts/admin_layout"
  before_action :check_admin
  private
  def check_admin
    if !logged_in?
      store_location
      flash[:warning] = t("controllers.errors.requied_login")
      redirect_to login_url
    elsif !admin?
      flash[:warning] = t("controllers.errors.only_admin_role")
      redirect_to login_url
    end
  end
end
