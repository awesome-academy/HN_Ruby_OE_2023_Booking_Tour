class ReviewsController < ApplicationController
  before_action :find_tour, only: %i(review)
  def review
    @review = Review.new(user: current_user, tour: @tour)
    form_frame
  end

  def index
    # reivews_frame
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash.now[:success] = "Review created successfully"

      close_review_frame
    else
      flash.now[:danger] = "Review created unsuccessfully"

      form_frame(:unprocessable_entity)
    end
  end
  private
  def find_tour
    @tour = Tour.find_by(id: params[:id])
    return if @tour

    flash[:success] = t("tour_details.message.not_found")
    redirect_to tours_path
  end

  def form_frame status = :ok
    render turbo_stream: [
             turbo_stream.replace(:review_form, partial: "reviews/form",
                                  locals: {review: @review}),
              turbo_stream.append(:flash, partial: "shared/flash_messages",
                                  locals: {flash:})
           ],
           status:
  end

  def close_review_frame
    render turbo_stream: [
      turbo_stream.remove(:review_form),
      turbo_stream.append(:flash, partial: "shared/flash_messages",
                          locals: {flash:})
    ]
  end

  def review_params
    params.require(:review).permit(Review::REVIEW_PRAMS)
  end
end
