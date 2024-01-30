class ImageReview < ApplicationRecord
  belongs_to :review
  validates :image_url, presence: true
end
