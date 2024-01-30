class AddImageReviewRefToReivew < ActiveRecord::Migration[7.0]
  def change
    add_reference :image_reviews, :review, null: false,
                  foreign_key: true
  end
end
