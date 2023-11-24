class CreateFollowTours < ActiveRecord::Migration[7.0]
  def change
    create_table :follow_tours do |t|
      t.references :users, null: false, foreign_key: true
      t.references :tours, null: false, foreign_key: true

      t.timestamps
    end
  end
end
