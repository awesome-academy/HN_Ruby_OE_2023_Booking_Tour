# app/models/tour_category.rb

class TourCategory < ApplicationRecord
  has_many :tours, dependent: :destroy

  validates :category_name, presence: true
  # Add any additional validations as needed
end
