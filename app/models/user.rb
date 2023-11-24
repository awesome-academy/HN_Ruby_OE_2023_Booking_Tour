class User < ApplicationRecord
  has_many :bookings, dependent: :nullify
  has_many :reviews, dependent: :destroy
  has_many :tour_followings, dependent: :destroy
  has_many :followed_tours, through: :tour_followings, source: :tour
  validates :email, presence: true
  validates :phone, presence: true
  validates :image, presence: true
  validates :password_digest, presence: true

  has_secure_password
end
