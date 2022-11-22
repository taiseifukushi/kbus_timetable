require "active_csv"

class Timetable < ActiveCsv::Base
  self.table_path = "data/csv/timetable.csv"
  belongs_to :busstop

  # include TimetableService

  class << self
    def search_departure_time; end

    def search_arrival_time; end

    def search_waiting_time_at_relay_point; end

    def require_relay?; end
  end
end
