module Util
  module TimeProcessor
    module_function

    def processing_arrival_time(arrival_time)
      Time.zone.parse(arrival_time)
    end

    def current_time
      Time.zone.now
    end
  end
end