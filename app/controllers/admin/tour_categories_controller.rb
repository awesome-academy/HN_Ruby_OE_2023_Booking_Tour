class Admin::TourCategoriesController < Admin::BaseController
  before_action :find_tour_category, only: %i(show edit update destroy)

  def index
    @pagy, @tour_categories = pagy(TourCategory.new_category)
  end

  def show; end

  def edit; end

  def update
    if @tour_category.update(tour_category_params)
      flash[:success] = t("tour_categories.flash_messages.edit_success")
      redirect_to admin_tour_categories_path
    else
      flash[:danger] = t("tour_categories.flash_messages.edit_failure")
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @tour_category = TourCategory.new(tour_category_params)
    if @tour_category.save
      flash[:success] = t("tour_categories.flash_messages.create_success")
      redirect_to admin_tour_categories_path
    else
      flash[:danger] = t("tour_categories.flash_messages.create_failure")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @tour_category.destroy

    if @tour_category.errors.any?
      flash[:danger] = t("tour_categories.flash_messages.destroy_failure") +
                       " #{@tour_category.errors.full_messages.join(', ')}"
    else
      flash[:success] =
        t("tour_categories.flash_messages.destroy_success")
    end
    redirect_to admin_tour_categories_path
  end

  def new
    @tour_category = TourCategory.new
  end

  private

  def tour_category_params
    params.require(:tour_category).permit(TourCategory::CREATE_PARAMS)
  end

  def find_tour_category
    @tour_category = TourCategory.find_by(id: params[:id])

    return if @tour_category

    flash[:danger] = t("tour_categories.flash_messages.not_found")
    redirect_to admin_tour_categories_path
  end
end
