class CreateTourDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :tour_details do |t|
      t.text :detail_description
      t.string :tour_detail_name, null: false
      t.integer :max_people
      t.string :start_location, null: false
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps
    end

  end
end
