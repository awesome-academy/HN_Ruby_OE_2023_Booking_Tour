class ImageTour < ApplicationRecord
  belongs_to :tour
  validates :image_url, presence: true
end
