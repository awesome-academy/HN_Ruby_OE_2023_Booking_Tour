class Booking < ApplicationRecord
  BOOKING_PARAMS = [:phone, :numbers_people, :tour_detail_id,
                    :date_start, :user_id].freeze
  belongs_to :tour_detail
  belongs_to :user
  validates :phone, presence: true
  validates :date_start, presence: true
  validates :numbers_people, presence: true,
            numericality: {only_integer: true,
                           greater_than: Settings.peoples_booking_tours_min}
  validate :booking_date_in_future
  scope :new_bills, ->{order(created_at: :desc)}

  before_create :update_prices, :status_booking
  enum status: {
    pending: 0,
    confirmed: 1,
    canceled: 2,
    success: 3
  }
  private

  def booking_date_in_future
    return unless date_start.present? && date_start <= Time.zone.now

    errors.add(:date_start, I18n.t("bookings.errors.date_in_fulture"))
  end

  def cancel_booking
    update(status: :canceled)
  end

  def confirm_booking
    return unless pending?

    update(status: :confirmed)
  end

  def success_booking
    return unless confirmed?

    update(status: :success)
  end

  def update_prices
    self.total_amount = tour_detail.price * numbers_people
  end

  def status_booking
    self.status = :pending
  end
end
