class CreateRouteDirections < ActiveRecord::Migration[5.1]
  def change
    create_table :route_directions do |t|
      t.column :route_id, :integer
      t.column :direction_id, :integer
      t.column :direction_name, :string

      t.timestamps
    end
  end
end
