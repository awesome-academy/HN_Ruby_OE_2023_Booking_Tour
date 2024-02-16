class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_tour, only: %i(create destroy)

  def create
    current_user.following_tour(@tour)
    flash.now[:success] = t("tours.follow_success")
    update_tour_frame
  end

  def destroy
    current_user.unfollow_tour(@tour)
    flash.now[:success] = t("tours.unfollow_success")
    update_tour_frame
  end

  private

  def load_tour
    @tour = Tour.find_by id: params[:id]
  end

  def update_tour_frame
    render turbo_stream: [
      turbo_stream.replace(@tour, partial: "tours/information",
                          locals: {tour: @tour}),
      turbo_stream.append(:flash, partial: "shared/flash_messages",
                          locals: {flash:})
    ]
  end
end
