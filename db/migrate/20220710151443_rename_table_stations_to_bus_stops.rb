class RenameTableStationsToBusStops < ActiveRecord::Migration[7.0]
  def change
    rename_table :stations, :bus_stops
  end
  # def up
  #   rename_table :stations, :bus_stops
  # end
end
