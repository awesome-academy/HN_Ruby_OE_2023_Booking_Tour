class Tour < ApplicationRecord
  belongs_to :tour_category
  has_many :tour_details, dependent: :destroy
  has_one :image_tour, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :tour_followings,
           class_name: TourFollowing.name, dependent: :destroy
  has_many :followed_users, through: :tour_followings, source: :user

  # has_many :tours, dependent: :destroy
  validates :tour_name, presence: true
  validates :time_duration, presence: true
end
