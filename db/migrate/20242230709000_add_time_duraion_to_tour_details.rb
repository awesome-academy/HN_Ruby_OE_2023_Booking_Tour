class AddTimeDuraionToTourDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :tour_details, :time_duration, :decimal ,:default => 0
  end
end
