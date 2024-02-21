class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_tour, only: %i(create destroy)

  def create
    current_user.following_tour(@tour)
    flash.now[:success] = t("tours.follow_success")
  end

  def destroy
    current_user.unfollow_tour(@tour)
    flash.now[:success] = t("tours.unfollow_success")
  end

  private

  def load_tour
    @tour = Tour.find_by id: params[:id]
  end
end
