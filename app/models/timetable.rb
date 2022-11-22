class Timetable < ApplicationModel
  self.table_path = "data/csv/timetable.csv"
  belongs_to :busstop

  class << self
  end
end
