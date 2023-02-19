# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_18_115742) do
  create_table "busstops", force: :cascade do |t|
    t.string "type"
    t.string "stop_id", null: false
    t.string "stop_name", null: false
    t.string "platform_code"
    t.string "stop_lat", null: false
    t.string "stop_lon", null: false
    t.string "zone_id", null: false
    t.string "location_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timetables", force: :cascade do |t|
    t.string "trip_id", null: false
    t.string "arrival_time", null: false
    t.string "departure_time", null: false
    t.string "stop_id", null: false
    t.string "stop_sequence", null: false
    t.string "stop_headsign", null: false
    t.string "pickup_type", null: false
    t.string "drop_off_type", null: false
    t.integer "busstop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["busstop_id"], name: "index_timetables_on_busstop_id"
  end

  add_foreign_key "timetables", "busstops"
end
