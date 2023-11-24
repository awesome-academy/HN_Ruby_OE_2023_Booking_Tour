class CreateTourDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :tour_details do |t|
      t.string :name
      t.decimal :price
      t.integer :max_people
      t.string :description
      t.string :start_location

      t.timestamps
    end
  end
end
