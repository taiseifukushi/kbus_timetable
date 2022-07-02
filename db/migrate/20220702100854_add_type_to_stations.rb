class AddTypeToStations < ActiveRecord::Migration[7.0]
  def change
    add_column :stations, :type, :string
  end
end
