class TourDetail < ApplicationRecord
  TOURDETAIL_PARAMS = [:tour_detail_name, :detail_description,
                        :max_people, :start_location, :price,
                        :tour_id, :time_duration].freeze
  belongs_to :tour
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings, source: :review

  validates :detail_description, presence: true
  validates :tour_detail_name, presence: true
  validates :max_people, presence: true,
            numericality: {greater_than_or_equal_to:
            Settings.peoples_booking_min}
  validates :start_location, presence: true
  validates :price, presence: true,
            numericality: {greater_than_or_equal_to:
            Settings.price_min}
  validates :time_duration, presence: true,
            numericality: {greater_than_or_equal_to:
            Settings.time_during_min}
end
