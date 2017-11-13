class AddServiceIdIndex < ActiveRecord::Migration[5.1]
  def change
    add_index :trips, :service_id
  end
end
