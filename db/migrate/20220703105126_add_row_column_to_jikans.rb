class AddRowColumnToJikans < ActiveRecord::Migration[7.0]
  def change
    add_column :jikans, :row, :integer, null: false
  end
end
