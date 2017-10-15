class AlterTrips < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :block_id, :integer
    add_index :stops, :agency_id
    add_index :stops, :local_id
    add_index :trips, :local_id
    add_index :trips, :block_id
    add_index :stop_times, :stop_id
    add_index :stop_times, :trip_id
  end
end
