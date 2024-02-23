class ReviewsController < ApplicationController
  before_action :check_user
  before_action :store_location, only: %i(edit)
  before_action :exit_review, only: %i(new)
  before_action :check_owner, only: %i(destroy edit update)
  def new
    @review = @booking.build_review
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = t "reviews.errors.review_created"

      redirect_to booking_path(@review.booking)
    else
      flash[:danger] =
        build_message @review, t("reviews.errors.review_unsuccessfull")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "reviews.errors.delete_successful"
      redirect_back(fallback_location: root_path)
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

      redirect_to tour_path(@review.booking.tour_detail.tour)
    else
      flash[:danger] =
        build_message @review, t("reviews.errors.edit_unsuccessful")
      render :edit, status: :unprocessable_entity
    end
  end
  private
  def find_booking
    @booking = Booking.find_by(id: params[:booking_id])
    return if @booking

    flash[:warning] = t "reviews.errors.booking_not_found"
    redirect_to bookings_path
  end

  def find_review
    @review = Review.find_by(id: params[:id])
    return if @review

    flash[:warning] = t "reviews.errors.reviews_not_found"
    redirect_to bookings_path
  end

  def check_owner
    find_review
    return if @review.user == current_user

    flash[:warning] = t "reviews.errors.not_your_review"
    redirect_to root_path
  end

  def exit_review
    find_booking
    return unless Review.review_existed? @booking

    flash[:warning] = t "reviews.errors.review_existed"
    redirect_to root_path
  end

  def review_params
    params.require(:review).permit(Review::REVIEW_PRAMS)
  end
end
