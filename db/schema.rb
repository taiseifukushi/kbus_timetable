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

ActiveRecord::Schema[7.0].define(version: 2022_07_10_153703) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bus_stops", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "is_relay_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
  end

  create_table "jikans", force: :cascade do |t|
    t.bigint "bus_stop_id"
    t.integer "order", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "get_on_time_hour"
    t.integer "get_on_time_minute"
    t.integer "row", null: false
    t.index ["bus_stop_id"], name: "index_jikans_on_bus_stop_id"
  end

end
