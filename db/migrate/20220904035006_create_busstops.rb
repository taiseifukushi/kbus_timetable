class CreateBusstops < ActiveRecord::Migration[7.0]
  def change
    create_table :busstops do |t|
      t.string :name, null: false
      t.boolean :is_relay_point, null: false
      t.string :type
      t.integer :stop_id

      t.timestamps
    end
  end
end
