class Review < ApplicationRecord
  REVIEW_PRAMS = [:review_text, :booking_id].freeze

  belongs_to :booking
  accepts_nested_attributes_for :booking
  has_one :user, through: :booking, source: :user
  validates :review_text, presence: true
  validates :booking_id, uniqueness: true
  scope :new_review, ->{order(created_at: :desc)}
  class << self
    def review_existed? booking
      Review.find_by(booking_id: booking.id)
    end
  end
end
