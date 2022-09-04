class CreateTimetables < ActiveRecord::Migration[7.0]
  def change
    create_table :timetables do |t|
      t.references :busstops
      t.integer :order
      t.integer :get_on_time_hour, null: false
      t.integer :get_on_time_minute, null: false
      t.integer :row, null: false
      t.string :stop_id, null: false, index: true
      t.datetime :arrival_time, null: false
      t.datetime :departure_time, null: false
      t.integer :stop_sequence
      t.string :stop_headsign
      t.string :pickup_type
      t.integer :drop_off_type

      t.timestamps
    end
  end
end
