class ReviewsController < ApplicationController
  before_action :check_user
  before_action :find_tour, only: %i(new)
  before_action :find_review, only: %i(destroy edit update)
  def new
    @review = Review.new(user: current_user, tour: @tour)
    return unless @review.review_existed?

    flash[:warning] = t "reviews.errors.review_existed"
    redirect_to tour_path @tour
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = t "reviews.errors.review_created"
      redirect_to tour_path(@review.tour)
    else
      flash[:danger] =
        build_message @review, t("reviews.errors.review_unsuccessfull")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "reviews.errors.delete_successful"
      redirect_to tour_path(@review.tour)
    else
      flash[:danger] =
        build_message @review, t("reviews.errors.delete_unsuccessful")
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      flash[:success] = t "reviews.errors.edit_successful"
      redirect_to tour_path(@review.tour)
    else
      flash[:danger] =
        build_message @review, t("reviews.errors.edit_unsuccessful")
      render :new, status: :unprocessable_entity
    end
  end
  private
  def find_tour
    @tour = Tour.find_by(id: params[:id])
    return if @tour

    flash[:warning] = t "reviews.errors.tour_not_found"
    redirect_to tours_path
  end

  def find_review
    @review = Review.find_by(id: params[:id])
    return if @review

    flash[:warning] = t "reviews.errors.reviews_not_found"
    redirect_to tours_path
  end

  def check_owner
    find_review
    return if @review.user == current_user

    flash[:warning] = t "reviews.errors.not_your_review"
    redirect_to tour_path(@review.tour)
  end

  def review_params
    params.require(:review).permit(Review::REVIEW_PRAMS)
  end
end
