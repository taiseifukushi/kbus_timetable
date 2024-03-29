class Busstop < ApplicationModel
  self.table_path = "#{Rails.root}/data/csv/busstops.csv"
  has_many :timetable
  self.primary_key = "stop_id"

  class << self
    def busstops_cache
      @busstops ||= busstops
    end

    private

    def busstops
      busstops = Busstop.pluck(:stop_id, :stop_name)
      busstops.each_with_object([]) do |busstop, array|
        _hash = {}
        _hash[:stop_id]   = busstop[0]
        _hash[:stop_name] = busstop[1]
        array.push(_hash)
      end
    end
  end
end
