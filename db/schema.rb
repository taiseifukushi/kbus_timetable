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

ActiveRecord::Schema[7.0].define(version: 2022_09_04_035048) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "busstops", force: :cascade do |t|
    t.string "type"
    t.boolean "is_relay_point", null: false
    t.string "stop_id", null: false
    t.string "stop_name", null: false
    t.float "stop_lat", null: false
    t.float "stop_lon", null: false
    t.string "zone_id", null: false
    t.string "platform_code"
    t.string "location_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timetables", force: :cascade do |t|
    t.bigint "busstops_id"
    t.integer "order"
    t.integer "get_on_time_hour", null: false
    t.integer "get_on_time_minute", null: false
    t.integer "row", null: false
    t.string "stop_id", null: false
    t.datetime "arrival_time", null: false
    t.datetime "departure_time", null: false
    t.integer "stop_sequence"
    t.string "stop_headsign"
    t.string "pickup_type"
    t.integer "drop_off_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["busstops_id"], name: "index_timetables_on_busstops_id"
    t.index ["stop_id"], name: "index_timetables_on_stop_id"
  end

end
