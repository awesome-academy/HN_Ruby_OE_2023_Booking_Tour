class Admin::BillsController < Admin::BaseController
  before_action :set_bill, only: %i(confirm cancel)
  def index
    @pagy, @bills = pagy(Booking.new_bills,
                         items: Settings.users_on_page)
  end

  def cancel
    if @bill.cancel_booking(current_user)
      flash.now[:success] = t("bookings.cancel_success")
    else
      flash.now[:error] = t("bookings.cancel_error")
    end
    update_bill_frame
  end

  def confirm
    if @bill.confirm_booking(current_user)
      flash.now[:success] = t("bookings.confirm_success")
    else
      flash.now[:error] = t("bookings.confirm_error")
    end
    update_bill_frame
  end
  private
  def set_bill
    @bill = Booking.find_by id: params[:id]
  end

  def update_bill_frame
    render turbo_stream: [
      turbo_stream.replace(@bill, partial: "admin/bills/bill",
locals: {bill: @bill}),
      turbo_stream.append(:flash, partial: "shared/flash_messages",
locals: {flash:})
    ]
  end
end
