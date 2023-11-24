class AddImageToursRefTours < ActiveRecord::Migration[7.0]
  def change
    add_reference :image_tours, :tours, foreign_key: true
  end
end
