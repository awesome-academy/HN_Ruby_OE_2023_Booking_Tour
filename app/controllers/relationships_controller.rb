class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_tour, only: %i(create destroy)

  def create
    current_user.following_tour(@tour)
    flash.now[:success] = t("tours.follow_success")
    redirect_to tours_path
  end

  def destroy
    current_user.unfollow_tour(@tour)
    flash.now[:success] = t("tours.unfollow_success")
    redirect_to tour_following_path
  end

  private

  def load_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour

    flash[:warning] = t("controllers.errors.booking_not_found")
    redirect_to root_path
  end
end
