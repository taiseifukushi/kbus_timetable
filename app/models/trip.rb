require 'active_csv'

class Trip < ActiveCsv::Base
  self.table_path = "data/csv/trip.csv"

  class << self
    def _to_route()
    end
  end
end
