class DropTimeDurationTour < ActiveRecord::Migration[7.0]
  def change
    remove_column :tours, :time_duration
  end
end
