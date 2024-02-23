class RemoveColumnTourFromReview < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :tour_id
  end
end
