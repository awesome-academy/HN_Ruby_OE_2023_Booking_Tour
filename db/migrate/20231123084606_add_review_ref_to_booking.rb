class AddReviewRefToBooking < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :booking, null: false,
                  foreign_key: true, unique: true

  end
end
