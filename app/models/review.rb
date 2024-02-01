# app/models/review.rb

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  validates :review_text, presence: true
end
