class AddIndexUsersAndToursToReviews < ActiveRecord::Migration[7.0]
  def change
    add_index :reviews, [:user_id, :tour_id], unique: true
  end
end
