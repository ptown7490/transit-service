class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.column :agency_id, :integer
      t.column :monday, :boolean
      t.column :tuesday, :boolean
      t.column :wednesday, :boolean
      t.column :thursday, :boolean
      t.column :friday, :boolean
      t.column :saturday, :boolean
      t.column :sunday, :boolean

      t.timestamps
    end

    remove_column :trips, :service_id
    add_column :trips, :service_id, :integer
  end
end
