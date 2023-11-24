# app/models/review.rb

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  has_many :image_reviews, dependent: :destroy

  validates :review_text, presence: true
  # Add any additional validations as needed
end
