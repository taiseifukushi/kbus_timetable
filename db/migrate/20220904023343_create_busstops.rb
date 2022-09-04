class CreateTimetables < ActiveRecord::Migration[7.0]
  def change
    create_table :timetables do |t|
      t.bigint "busstop_id"
      t.integer "order", null: false
      t.integer "get_on_time_hour"
      t.integer "get_on_time_minute"
      t.integer "row", null: false
      t.timestamps
    end
  end
end
