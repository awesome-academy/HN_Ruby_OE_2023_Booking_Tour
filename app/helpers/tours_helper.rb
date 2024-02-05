module ToursHelper
  def categories
    @categories = TourCategory.all
  end
end
