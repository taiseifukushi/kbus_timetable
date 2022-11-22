module Timetable
  module TimeProcessor
    module_function

    def processing_table_time()
      # Timetable.last[:arrival_time].class
      # "20:35:00"
    end

    def current_time
      Time.zone.now
    end
  end
end