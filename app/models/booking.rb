class Booking < ApplicationRecord
  belongs_to :user, class_name: User.name, foreign_key: :users_id
  belongs_to :tour_detail, class_name: TourDetail.name, foreign_key: :tour_details_id
end
