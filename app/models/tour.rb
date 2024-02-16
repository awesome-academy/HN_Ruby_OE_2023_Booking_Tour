class Tour < ApplicationRecord
  CREATE_PARAMS = [:tour_name, :time_duration, :hagtag,
                   :tour_description, :tour_category_id,
                   :image, :content].freeze
  has_rich_text :content
  belongs_to :tour_category
  has_one_attached :image do |attachable|
    attachable.variant :tour_image,
                       resize_to_limit: [Settings.high_avatar_icon,
                       Settings.width_avatar_icon]
  end
  has_many :tour_details, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :tour_followings,
           class_name: TourFollowing.name, dependent: :destroy
  has_many :followed_users, through: :tour_followings,
            source: :user

  validates :tour_name, presence: true
  validates :image, presence: true, allow_nil: true
  validates :time_duration, presence: true
  scope :new_tour, ->{order(created_at: :desc)}
end
