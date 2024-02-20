class Review < ApplicationRecord
  REVIEW_PRAMS = [:review_text, :user_id, :tour_id].freeze
  belongs_to :user
  belongs_to :tour
  validates :review_text, presence: true
  scope :new_review, ->{order(created_at: :desc)}
end
