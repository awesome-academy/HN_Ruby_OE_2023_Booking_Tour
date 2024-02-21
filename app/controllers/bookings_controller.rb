class BookingsController < ApplicationController
  before_action :check_user,
                only: %i(new create booking_history)
  before_action :set_tour_detail, only: %i(new)
  before_action :find_booking, only: %i(show cancel)
  before_action :check_owner, only: %i(cancel)
  after_action :update_bill_frame, only: %i(cancel)
  def new
    @booking = build_booking
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
    if @booking.pending?
      flash[:error] = t("bookings.cancel_error")
    elsif @booking.cancel_booking
      flash[:success] = t("bookings.cancel_success")
    else
      flash[:error] = t("bookings.cancel_error")
    end
  end

  def show; end

  def booking_history
    render_index_page(current_user.bookings)
  end

  private
  def check_owner
    set_booking
    return if current_user == @booking.user

    flash[:warning] = t("controllers.errors.requied_login")
    redirect_to root_path
  end

  def render_index_page bookings
    @pagy, @bookings = pagy(bookings)
    render "bookings/index"
  end

  def load_tour_detail
    @tour_detail = TourDetail.find_by(id: params[:id])
    return if @tour_detail

    flash[:warning] = t("controllers.errors.tour_detail_not_found")
    redirect_to root_path
  end

  def find_booking
    @booking = Booking.find_by(id: params[:id])
    return if @booking

    flash[:warning] = t("controllers.errors.booking_not_found")
    redirect_to root_path
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
