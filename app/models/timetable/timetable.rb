require "active_csv"

class Timetable < ActiveCsv::Base
  self.table_path = "data/csv/timetable.csv"
  belongs_to :busstop

  include Timetable::TimeProcessor

  class << self
  end
end
