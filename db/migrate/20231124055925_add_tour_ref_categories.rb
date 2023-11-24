class AddTourRefCategories < ActiveRecord::Migration[7.0]
  def change
    add_reference :tours, :categories, foreign_key: true
  end
end
