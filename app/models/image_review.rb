class ImageReview < ApplicationRecord
  belongs_to :review, class_name: Review.name, foreign_key: :reviews_id
end
