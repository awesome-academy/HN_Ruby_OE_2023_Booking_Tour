class Category < ApplicationRecord
  has_many :tours, class_name: Tour.name, foreign_key: :categories_id
end
