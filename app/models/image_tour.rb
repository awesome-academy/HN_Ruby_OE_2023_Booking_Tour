class ImageTour < ApplicationRecord
  belongs_to :tour, class_name: Tour.name, foreign_key: :tours_id
end
