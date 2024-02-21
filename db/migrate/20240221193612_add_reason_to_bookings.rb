class AddReasonToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :reason, :string
  end
end
