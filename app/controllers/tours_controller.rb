class ToursController < ApplicationController
  before_action :set_tour, only: %i(show edit update)
  def home; end

  def index
    @pagy, @tours = pagy(Tour.new_tour,
                         items: Settings.tours_on_page)
  end

  def show; end

  def edit; end

  def update
    if @tour.update tour_params
      flash[:success] = t("tourcontroller.tour_edit_message")
      redirect_to @tour
    else
      render :edit
    end
  end

  def create
    @tour = Tour.new tour_params
    if @tour.save
      redirect_to tour_path(@tour)
    else
      render :new
    end
  end

  def new
    @tour = Tour.new
  end

  def detail; end

  private
  def set_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour

    redirect_to root_path
  end

  def tour_params
    params.require(:tour).permit(Tour::CREATE_PARAMS)
  end
end
