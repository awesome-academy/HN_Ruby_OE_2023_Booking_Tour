class BookingsController < ApplicationController
  before_action :require_logged_in_user, only: [:booking, :create]
  before_action :set_tour_detail, only: :booking
  before_action :set_booking, only: [:show, :cancel]

  def booking
    @booking = build_booking
    render :new
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      flash[:success] = t("bookings.create_success")
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def cancel
    if @booking.cancel_booking(current_user)
      flash[:success] = t("bookings.cancel_success")
    else
      flash[:error] = t("bookings.cancel_error")
    end
    update_bill_frame
  end

  def show
    redirect_to bookings_path unless @booking
  end

  def booking_history
    render_index_page(current_user.bookings.new_bills)
  end

  def booking_following
    render_index_page(current_user.followed_tours.new_bills)
  end

  private

  def render_index_page bookings
    @pagy, @bookings = pagy(bookings, items: Settings.tours_on_page)
    render "bookings/index"
  end

  def find_user
    @user = User.find_by(id: params[:id])
    redirect_to users_path unless @user
  end

  def require_logged_in_user
    redirect_to login_path unless logged_in?
  end

  def set_tour_detail
    @tour_detail = TourDetail.find_by(id: params[:id])
  end

  def set_booking
    @booking = Booking.find_by(id: params[:id])
  end

  def booking_params
    params.require(:booking).permit(Booking::BOOKING_PARAMS)
  end

  def build_booking
    Booking.new(
      tour_detail: @tour_detail,
      user: current_user,
      numbers_people: Settings.peoples_booking_tours
    )
  end

  def update_bill_frame
    render turbo_stream: [
      turbo_stream.replace(@booking, partial: "bookings/status",
locals: {booking: @booking}),
      turbo_stream.append(:flash, partial: "shared/flash_messages",
locals: {flash:})
    ]
  end
end
