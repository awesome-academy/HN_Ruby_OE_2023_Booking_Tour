class TourFollowing < ApplicationRecord
  belongs_to :tour, class_name: Tour.name
  belongs_to :user, class_name: User.name
end
