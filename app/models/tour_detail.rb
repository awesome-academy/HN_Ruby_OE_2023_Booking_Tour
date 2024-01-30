class TourDetail < ApplicationRecord
  belongs_to :tour
  has_many :bookings, dependent: :destroy

  validates :detail_description, presence: true
  validates :tour_detail_name, presence: true
  validates :max_people, presence: true, numericality: {greater_than: 0}
  validates :start_location, presence: true
  validates :price, presence: true,
numericality: {greater_than_or_equal_to: 0}
end
