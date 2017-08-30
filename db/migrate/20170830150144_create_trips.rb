class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.column :route_direction_id, :integer

      t.timestamps
    end
  end
end
