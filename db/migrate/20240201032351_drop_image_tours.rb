class DropImageTours < ActiveRecord::Migration[7.0]
  def change
    drop_table :image_tours
  end
end
