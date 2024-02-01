class Booking < ApplicationRecord
  BOOKING_PARAMS = [:phone, :numbers_people, :tour_detail_id,
                    :date_start, :user_id].freeze
  belongs_to :tour_detail
  belongs_to :user
  before_create :update_prices, :status_booking
  enum status: {
    pending: 0,
    confirmed: 1,
    canceled: 2
  }

  def cancel_booking current_user
    return unless (pending? && user == current_user) || current_user.admin?

    update(status: :canceled)
  end

  def confirm_booking current_user
    return unless pending? && current_user.admin?

    update(status: :confirmed)
  end
  private

  def update_prices
    self.total_amount = tour_detail.price * numbers_people
  end

  def status_booking
    self.status = :pending
  end
  validates :phone, presence: true
  validates :date_start, presence: true
end
