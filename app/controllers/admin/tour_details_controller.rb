class Admin::TourDetailsController < Admin::BaseController
  before_action :find_tour_detail, only: %i(edit update show destroy)
  before_action :find_tour, only: %i(new)

  def new
    @tour_detail = TourDetail.new(tour: @tour)
  end

  def create
    @tour_detail = TourDetail.new(tour_detail_params)
    if @tour_detail.save
      flash[:success] = t("tour_details.message.success_create")
      redirect_to admin_tour_path(@tour_detail.tour)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def destroy
    @tourexit = @tour_detail.tour
    if @tour_detail.destroy
      flash[:success] = t("tour_details.tour_detail_deleted")
    else
      flash[:danger] = t("tour_details.tour_detail_fail")
    end
    redirect_to admin_tour_path(@tourexit)
  end

  def update
    if @tour_detail.update(tour_detail_params)
      flash[:success] = t("tour_details.message.success_update")
      redirect_to admin_tour_path(@tour_detail.tour)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def find_tour
    @tour = Tour.find_by(id: params[:id])
    return if @tour

    flash[:success] = t("tour_details.message.not_found")
    redirect_to admin_tours_path
  end

  def find_tour_detail
    @tour_detail = TourDetail.find_by(id: params[:id])
    return if @tour_detail

    flash[:success] = t("tour_details.message.not_found")
    redirect_to admin_tours_path
  end

  def tour_detail_params
    params.require(:tour_detail).permit(TourDetail::TOURDETAIL_PARAMS)
  end
end
