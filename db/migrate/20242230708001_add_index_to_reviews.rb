class AddIndexToReviews < ActiveRecord::Migration[7.0]
  def change
    add_index :reviews, :booking_id, unique: true, :name => "unique_booking_on_reviews"
  end
end
