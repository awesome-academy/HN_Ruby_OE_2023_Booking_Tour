class BookingsController < ApplicationController
  before_action :logged_in_user, only: [:booking, :create]
  before_action :set_tour_detail, only: :booking
  before_action :set_booking, only: [:show]

  def booking
    @booking = Booking.new(tour_detail: @tour_detail, user: current_user,
                           numbers_people: Settings.peoples_booking_tours)
    render_booking_form
  end

  def cancel
    @booking = Booking.find(params[:id])
    if @booking.cancel_booking(current_user)
      flash[:success] = t("bookings.cancel_success")
    else
      flash[:error] = t("bookings.cancel_error")
    end
    redirect_to @booking
  end

  def confirm
    @booking = Booking.find(params[:id])
    if @booking.confirm_booking(current_user)
      flash[:success] = t("bookings.confirm_success")
    else
      flash[:error] = t("bookings.confirm_error")
    end
    redirect_to @booking
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      render turbo_stream: turbo_stream.replace(
        "booking",
        partial: "bookings/preview",
        locals: {
          booking: @booking
        }
      )
    else
      render_booking_form(:unprocessable_entity)
    end
  end

  def show
    redirect_to bookings_path unless @booking
  end

  private

  def set_tour_detail
    @tour_detail = TourDetail.find_by(id: params[:id])
  end

  def set_booking
    @booking = Booking.find_by(id: params[:id])
  end

  def render_booking_form status = :ok
    render turbo_stream: turbo_stream.replace(
      "booking",
      partial: "bookings/form",
      locals: {
        booking: @booking,
        submit_text: t("bookings.form.booking")
      }
    ), status:
  end

  def booking_params
    params.require(:booking).permit(Booking::BOOKING_PARAMS)
  end
end
