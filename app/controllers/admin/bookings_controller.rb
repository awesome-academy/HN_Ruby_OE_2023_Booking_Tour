class Admin::BookingsController < Admin::BaseController
  before_action :find_booking, only: %i(confirm cancel_modal success cancel)
  def index
    @pagy, @bookings = pagy(Booking.new_bookings)
  end

  def filter
    @pagy, @bookings = pagy(Booking.by_tour_and_date(
      params[:tour_detail_id], params[:date_start], params[:status]
    ).order(created_at: :desc))

    render "admin/bookings/index"
  end

  def cancel_modal; end

  def cancel
    @booking.update reason: params[:booking][:reason]
    @booking.cancel_booking
    flash.now[:success] = t("bookings.cancel_success")
  end

  def success
    if @booking.success_booking
      flash.now[:success] = t("bookings.cancel_success")
    else
      flash.now[:error] = t("bookings.cancel_error")
    end
  end

  def confirm
    if @booking.confirm_booking
      flash.now[:success] = t("bookings.confirm_success")
    else
      flash.now[:error] = t("bookings.confirm_error")
    end
  end
  private
  def find_booking
    @booking = Booking.find_by id: params[:id]
    return if @booking

    flash[:warning] = t("controllers.errors.booking_not_found")
    redirect_to admin_bookings_path
  end
end
