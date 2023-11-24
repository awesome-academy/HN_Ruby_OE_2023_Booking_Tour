class User < ApplicationRecord
  has_many :follow_tours, class_name: FollowTour.name,
  foreign_key: :users_id, dependent: :destroy
  has_many :review_tours, class_name: Review.name,
  foreign_key: :users_id, dependent: :destroy
  has_many :followed_tours, through: :follow_tours, source: :tour
  has_many :bookings, class_name: Booking.name,
  foreign_key: :users_id, dependent: :destroy
  has_many :reviews, through: :review_tours, source: :tour
  has_many :tours_booked, through: :bookings, source: :tour_detail
  def follow_tour(tour)
    follow_tours << FollowTour.new(tour: tour)
  end

  def unfollow_tour(tour)
    follow_tours.find_by(tour: tour)&.destroy
  end

  def following_tour?(tour)
    followed_tours.include?(tour)
  end
  def distinct_tours_booked
    self.tours_booked.select('DISTINCT tour_details.*')
  end
end
