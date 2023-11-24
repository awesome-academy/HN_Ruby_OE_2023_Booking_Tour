class AddTourDetailsRefTours < ActiveRecord::Migration[7.0]
  def change
    add_reference :tour_details, :tours, foreign_key: true
  end
end
