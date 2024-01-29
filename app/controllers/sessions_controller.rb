class SessionsController < ApplicationController
  before_action :check_user, only: :create

  def new; end

  def create
    if @user.authenticate params.dig(:session, :password)
      log_in @user
      if params.dig(:session, :remember_me)
        remember @user
      else
        forget @user
      end
    end
    redirect_back_or root_url
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def check_user
    @user = User.find_by email: params.dig(:session, :email)
    return if @user

    flash.now[:danger] = t("user.loginpage.not_found_user")
    render :new, status: :unprocessable_entity
  end
end
