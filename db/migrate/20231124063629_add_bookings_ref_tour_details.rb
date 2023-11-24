class AddBookingsRefTourDetails < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :tour_details, foreign_key: true
  end
end
