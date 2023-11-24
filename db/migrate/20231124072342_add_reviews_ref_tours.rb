class AddReviewsRefTours < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :tours, foreign_key: true
  end
end
