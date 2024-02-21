class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.date :booking_date
      t.string :phone, null: false
      t.date :date_start
      t.date :end_date
      t.integer :numbers_people
      t.decimal :total_amount, precision: 10, scale: 2
      t.integer :status
      t.timestamps
    end
  end
end
