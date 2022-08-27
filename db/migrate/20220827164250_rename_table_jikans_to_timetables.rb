class RenameTableJikansToTimetables < ActiveRecord::Migration[7.0]
  def change
    rename_table :jikans, :timetables
  end
end
