class Review < ApplicationRecord
  REVIEW_PRAMS = [:review_text, :user_id, :tour_id].freeze
  belongs_to :user
  belongs_to :booking
  validates :review_text, presence: true
  validates :user_id, uniqueness: {scope: :tour_id,
                                   message: I18n.t("reviews.errors.unique")}
  scope :new_review, ->{order(created_at: :desc)}

  def review_existed?
    !!Review.find_by(user:, booking:)
  end
end
