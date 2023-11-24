class Tour < ApplicationRecord
  belongs_to :category, class_name: Category.name, foreign_key: :categories_id
  has_many :follow_tours, class_name: FollowTour.name, foreign_key: :tours_id, dependent: :destroy
  has_many :followers, through: :follow_tours, source: :user
  has_many :images, class_name: ImageTour.name, foreign_key: :tours_id, dependent: :destroy
  has_many :reviews, class_name: Review.name, foreign_key: :tours_id, dependent: :destroy
  has_many :tourdetails, class_name: TourDetail.name, foreign_key: :tours_id, dependent: :destroy
end
