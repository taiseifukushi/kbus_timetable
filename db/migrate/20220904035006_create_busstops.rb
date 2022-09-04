class CreateBusstops < ActiveRecord::Migration[7.0]
  def change
    create_table :busstops do |t|
      t.string :type
      t.boolean :is_relay_point, null: false
      t.string :stop_id, null: false
      t.string :stop_name, null: false
      t.float :stop_lat, null: false
      t.float :stop_lon, null: false
      t.string :zone_id, null: false
      t.string :platform_code
      t.string :location_type

      t.timestamps
    end
  end
end
