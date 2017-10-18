class AddServiceId < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :service_id, :string
  end
end
