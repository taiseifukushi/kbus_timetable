class CreateTimetables < ActiveRecord::Migration[7.0]
  def change
    create_table :timetables do |t|
      t.references :busstops
      t.integer :order, null: false
      t.integer :get_on_time_hour, null: false
      t.integer :get_on_time_minute, null: false
      t.integer :row, null: false
      t.integer :stop_sequence
      t.datetime :arrival_time
      t.datetime :departure_time

      t.timestamps
    end
  end
end
