class CreateTourCategorys < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_categories do |t|
      t.string :category_name, null: false

      t.timestamps
    end
  end
end
