class Review < ApplicationRecord
  REVIEW_PRAMS = [:review_text, :tour_id].freeze
  belongs_to :booking
  has_one :user, through: :booking, source: :user
  validates :review_text, presence: true
  scope :new_review, ->{order(created_at: :desc)}

  def review_existed?
    !!Review.find_by(booking:)
  end
end
