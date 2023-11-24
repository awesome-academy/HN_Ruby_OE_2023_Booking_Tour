class FollowTour < ApplicationRecord
  belongs_to :user, class_name: User.name, foreign_key: :users_id
  belongs_to :tour, class_name: Tour.name, foreign_key: :tours_id
end
