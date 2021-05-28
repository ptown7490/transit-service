class AddLocationIdIndex < ActiveRecord::Migration[5.1]
  def change
    add_index :stops, :location_id
  end
end
