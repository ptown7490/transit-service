class UpdateTrips < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :local_id, :string
  end
end
