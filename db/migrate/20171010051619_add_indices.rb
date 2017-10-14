class AddIndices < ActiveRecord::Migration[5.1]
  def change
    add_index :routes, :agency_id
    add_index :route_directions, :route_id
    add_index :trips, :route_direction_id
  end
end
