class CreateBusstops < ActiveRecord::Migration[7.0]
  def change
    create_table :busstops do |t|
      t.string :type
      t.string :stop_id, null: false
      t.string :stop_name, null: false
      t.string :platform_code
      t.string :stop_lat, null: false
      t.string :stop_lon, null: false
      t.string :zone_id, null: false
      t.string :location_type, null: false
      t.timestamps
    end
  end
end
