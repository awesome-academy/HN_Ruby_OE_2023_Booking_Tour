class UsersController < ApplicationController
  before_action :set_user, only: %i(show)

  def index
    @pagy, @users = pagy(User.new_user)
  end

  def following_tour
    @pagy, @tours = pagy(current_user.followed_tours)
    render "tours/index"
  end

  def show; end

  private

  def set_user
    @user = User.find_by id: params[:id]
    return if @user

    redirect_to users_path
  end

  def user_params
    params.require(:user).permit(User::SIGNUP_PARAMS)
  end
end
