class CreateStops < ActiveRecord::Migration[5.1]
  def change
    create_table :stops do |t|
      t.column :agency_id, :integer
      t.column :local_id, :string
      t.column :name, :string
      t.column :latitude, :float
      t.column :longitude, :float

      t.timestamps
    end
  end
end
