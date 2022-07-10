class RenameColumnStationIdToBusStopId < ActiveRecord::Migration[7.0]
  def change
    rename_column :jikans, :station_id, :bus_stop_id
  end
end
