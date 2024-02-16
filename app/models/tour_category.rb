class TourCategory < ApplicationRecord
  CREATE_PARAMS = [:category_name].freeze
  has_many :tours, dependent: :destroy

  validates :category_name, presence: true
  scope :new_category, ->{order(created_at: :desc)}
end
