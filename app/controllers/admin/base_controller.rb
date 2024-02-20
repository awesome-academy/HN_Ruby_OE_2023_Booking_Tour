class Admin::BaseController < ApplicationController
  layout "admin/layouts/admin_layout"
  before_action :check_admin
  private
  def check_admin
    if !logged_in?
      store_location
      redirect_to login_url
    elsif !admin?
      render status: :forbidden, file: Rails.root.join("public/403.html"),
             layout: false
    end
  end
end
