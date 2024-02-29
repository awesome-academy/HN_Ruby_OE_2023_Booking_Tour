class Booking < ApplicationRecord
  BOOKING_PARAMS = [:phone, :numbers_people, :tour_detail_id,
                    :date_start, :user_id].freeze
  belongs_to :tour_detail
  belongs_to :user
  has_one :review, dependent: :destroy, class_name: Review.name
  validates :phone, presence: true, phone: true
  validates :date_start, presence: true
  validates :numbers_people, presence: true,
            numericality: {only_integer: true,
                           greater_than_or_equal_to:
                           Settings.peoples_booking_min}
  validate :booking_date_in_future
  validate :out_of_peoples, if: ->{numbers_people.present?}
  scope :new_bills, ->{order(created_at: :desc)}

  before_create :update_prices, :status_booking
  before_save :caculate_end_date
  enum status: {
    pending: 0,
    confirmed: 1,
    canceled: 2,
    successed: 3
  }

  def cancel_booking
    reload
    raise I18n.t("bookings.errors.update_status_fail") unless pending?

    update(status: 2)
  end

  def confirm_booking
    return unless pending?

    update(status: 1)
  end

  private

  def booking_date_in_future
    return unless date_start.present? && date_start <= Time.zone.now

    errors.add(:date_start, I18n.t("bookings.errors.date_in_fulture"))
  end

  def out_of_peoples
    return if numbers_people <= tour_detail.max_people

    errors.add(:numbers_people,
               I18n.t("bookings.errors.out_of_people",
                      max_people: tour_detail.max_people))
  end

  def update_prices
    self.total_amount = tour_detail.price * numbers_people
  end

  def status_booking
    self.status = :pending
  end

  def caculate_end_date
    self.end_date = date_start + tour_detail.time_duration.days
  end
end
