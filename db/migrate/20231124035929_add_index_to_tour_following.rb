class AddIndexToTourFollowing < ActiveRecord::Migration[7.0]
  def change
    add_index :tour_followings, [:user_id, :tour_id], unique: true
  end
end
