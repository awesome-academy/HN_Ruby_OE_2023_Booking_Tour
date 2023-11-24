class CreateTours < ActiveRecord::Migration[7.0]
  def change
    create_table :tours do |t|
      t.string :name
      t.string :time_duration
      t.string :hagtag
      t.string :description

      t.timestamps
    end
  end
end
