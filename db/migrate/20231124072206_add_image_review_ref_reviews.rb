class AddImageReviewRefReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :image_reviews, :reviews, foreign_key: true
  end
end
