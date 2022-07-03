class ChangeGetOnTimeColumnToJikans < ActiveRecord::Migration[7.0]
  def change
    remove_column :jikans, :get_on_time, :time
    add_column :jikans, :get_on_time_hour, :integer
    add_column :jikans, :get_on_time_minute, :integer
  end
end
