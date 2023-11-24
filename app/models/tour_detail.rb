class TourDetail < ApplicationRecord
  belongs_to :tour, class_name: Tour.name, foreign_key: :tours_id
  has_many :bookings, class_name: Booking.name, foreign_key: :tour_details_id, dependent: :destroy
end
