class ToursController < ApplicationController
  before_action :set_tour, only: %i(show)

  def home; end

  def index
    @pagy, @tours = pagy(Tour.new_tour)
  end

  def show
    # @pagy, @reviews = pagy(@tour.reviews.new_review)
  end
  private
  def set_tour
    @tour = Tour.find_by(id: params[:id])
    return if @tour

    flash[:success] = t("tour_details.message.not_found")
    redirect_to admin_tours_path
  end
end
