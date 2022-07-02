class CreateJikans < ActiveRecord::Migration[7.0]
  def change
    create_table :jikans do |t|
      t.references :station_id
      t.time      :get_on_time, null: false
      t.integer   :order, null: false
      t.timestamps
    end
  end
end
