class AddReviewRefToTour < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :tour, null: false,
                  foreign_key: true
  end
end
