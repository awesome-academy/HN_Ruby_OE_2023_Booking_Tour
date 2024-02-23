class Admin::ChartsController < ApplicationController
  before_action :validate_filter_params, only: %i(filter)
  before_action :range_filter, expect: %i(filter)

  def incomes
    render json: Booking.incomes(@datefrom, @dateto)
  end

  def status_booking
    render json: Booking.status_bookings(@datefrom, @dateto)
  end

  def new_booking
    render json: Booking.new_booking_hash_order(@datefrom, @dateto)
  end

  def users_signup
    render json: User.users_signup(@datefrom, @dateto)
  end

  def filter; end

  private

  def validate_filter_params
    @parsed_date_form = Date.parse(params[:dateform])
    @parsed_date_to = Date.parse(params[:dateto])

    handle_date_order_error if @parsed_date_form >= @parsed_date_to
  rescue ArgumentError
    handle_invalid_date_format_error
  end

  def handle_date_order_error
    flash[:danger] = t("home.date_order")
    redirect_to admin_dashboard_path
  end

  def handle_invalid_date_format_error
    flash[:danger] = t("home.invalid_format")
    redirect_to admin_dashboard_path
  end

  def range_filter
    @datefrom = parse_date(params[:datefrom])&.beginning_of_day ||
                Time.zone.now.beginning_of_month.midnight
    @dateto = parse_date(params[:dateto])&.end_of_day ||
              Time.zone.now
  end

  def parse_date date_param
    Time.zone.parse(date_param) if date_param.present?
  end
end
