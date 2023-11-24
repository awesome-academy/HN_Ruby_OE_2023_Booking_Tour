class CreateTours < ActiveRecord::Migration[7.0]
  def change
    create_table :tours do |t|
      t.string :tour_name, null: false
      t.string :time_duration, null: false
      t.string :hagtag
      t.text :tour_description

      t.timestamps
    end
  end
end
