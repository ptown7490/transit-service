class AlterTables < ActiveRecord::Migration[5.1]
  def change
    add_column :routes, :route_class, :integer

    add_column :stops, :location_class, :integer
    add_column :stops, :parent_station_id, :integer
    add_index :stops, :location_class
    add_index :stops, :parent_station_id

    remove_column :stop_times, :arrival_time
    remove_column :stop_times, :depart_time
    add_column :stop_times, :arrival_time, :datetime
    add_column :stop_times, :depart_time, :datetime
    add_index :stop_times, :arrival_time
    add_index :stop_times, :depart_time
  end
end
