class CreateBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :blocks do |t|
      t.column :agency_id, :integer
      t.column :local_id, :string
    end

    add_index :blocks, :agency_id
    add_index :blocks, :local_id
  end
end
