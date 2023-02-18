class CreateTimetables < ActiveRecord::Migration[7.0]
  def change
    create_table :timetables do |t|
      t.string :trip_id, null: false
      t.string :arrival_time, null: false
      t.string :departure_time, null: false
      t.string :stop_id, null: false
      t.string :stop_sequence, null: false
      t.string :stop_headsign, null: false
      t.string :pickup_type, null: false
      t.string :drop_off_type, null: false
      t.references :busstop, foreign_key: true
      t.timestamps
    end
  end
end
