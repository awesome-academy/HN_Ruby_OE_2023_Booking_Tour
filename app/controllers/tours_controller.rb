class ToursController < ApplicationController
  before_action :set_tour, only: %i(show edit update destroy)
  def home; end

  def index
    @pagy, @tours = pagy(Tour.new_tour,
                         items: Settings.tours_on_page)
  end

  def show; end

  def edit; end

  def update
    if @tour.update tour_params
      flash[:success] = t("tourcontroller.flash_messages.edit_message")
      redirect_to @tour
    else
      flash[:danger] = t("tourcontroller.flash_messages.edit_fail_message")
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @tour = Tour.new tour_params
    if @tour.save
      flash[:success] = t("tourcontroller.flash_messages.create_message")
      redirect_to tour_path(@tour)
    else
      flash[:danger] = t("tourcontroller.flash_messages.create_fail_message")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @tour.destroy
      flash[:success] = t("tourcontroller.flash_messages.deleted_success")
      redirect_to tours_path
    else
      flash[:danger] = t("tourcontroller.flash_messages.deleted_failure")
      render @tour
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
