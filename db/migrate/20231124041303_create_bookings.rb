class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.date :booking_date
      t.string :phone
      t.date :start_date
      t.date :end_date
      t.integer :numbers_people
      t.decimal :total_amount

      t.timestamps
    end
  end
end
