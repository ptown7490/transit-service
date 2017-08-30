class CreateRoutes < ActiveRecord::Migration[5.1]
  def change
    create_table :routes do |t|
      t.column :agency_id, :integer
      t.column :local_id, :string
      t.column :name, :string
      t.column :short_name, :string

      t.timestamps
    end
  end
end
