class CreateStations < ActiveRecord::Migration[7.0]
  def change
    create_table :stations do |t|
      t.string  :name, null: false
      t.boolean :is_relay_point
      t.timestamps
    end
  end
end
