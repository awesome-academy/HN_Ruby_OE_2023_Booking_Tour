class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  SIGNUP_PARAMS = [:username, :phone, :email,
                  :password, :avatar,
                  :password_confirmation].freeze
  # attr_accessor :remember_token

  has_many :bookings, dependent: :nullify
  has_one_attached :avatar do |attachable|
    attachable.variant :avatar_icon,
                       resize_to_limit: [Settings.high_avatar_icon,
                                         Settings.width_avatar_icon]
  end
  has_many :reviews, dependent: :destroy
  has_many :tour_followings, dependent: :destroy
  has_many :followed_tours, through: :tour_followings, source: :tour
  validates :email, presence: true
  validates :username, presence: true
  validates :phone, presence: true
  validates :password, presence: true, allow_nil: true
  validates :password_confirmation, presence: true, allow_nil: true
  scope :new_user, ->{order(created_at: :desc)}

  def following_tour tour
    followed_tours << tour unless followed_tours.include?(tour)
  end

  def unfollow_tour tour
    return unless followed_tours.include?(tour)

    followed_tours.delete(tour)
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end
end
