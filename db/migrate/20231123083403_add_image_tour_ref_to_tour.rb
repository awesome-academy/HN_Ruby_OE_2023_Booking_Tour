class AddImageTourRefToTour < ActiveRecord::Migration[7.0]
  def change
    add_reference :image_tours, :tour, null: false,
                  foreign_key: true
  end
end
