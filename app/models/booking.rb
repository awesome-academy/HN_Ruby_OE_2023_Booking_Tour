class Booking < ApplicationRecord
  belongs_to :tour_detail
  belongs_to :user

  enum status: {
    pending: 0,
    confirmed: 1,
    canceled: 2
  }
  validates :phone, presence: true
end
