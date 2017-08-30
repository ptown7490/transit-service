class CreateStopTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :stop_times do |t|
      t.column :stop_id, :integer
      t.column :trip_id, :integer
      t.column :stop_sequence, :integer
      t.column :arrival_time, :string
      t.column :depart_time, :string

      t.timestamps
    end
  end
end
