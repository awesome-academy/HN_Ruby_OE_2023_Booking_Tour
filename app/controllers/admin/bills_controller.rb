class Admin::BillsController < Admin::BaseController
  before_action :find_bill, only: %i(confirm cancel)
  def index
    @filter = ransack_params
    @filter.sorts ||= "created_at asc"
    @pagy, @bills = pagy(@filter.result(distinct: true))
  end

  def cancel
    if @bill.cancel_booking
      flash.now[:success] = t("bookings.cancel_success")
    else
      flash.now[:error] = t("bookings.cancel_error")
    end
    redirect_to admin_bills_path
  end

  def confirm
    if @bill.confirm_booking
      flash.now[:success] = t("bookings.confirm_success")
    else
      flash.now[:error] = t("bookings.confirm_error")
    end
    redirect_to admin_bills_path
  end
  private

  def ransack_params
    Booking.ransack(params[:query])
  end

  def find_bill
    @bill = Booking.find_by id: params[:id]
    return if @bill

    flash[:warning] = t("controllers.errors.bill_not_found")
    redirect_to admin_bills_path
  end
end
