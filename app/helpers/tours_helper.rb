module ToursHelper
  def categories
    @categories = TourCategory.all
  end

  def set_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour

    redirect_to root_path
  end
end
