module Caluculater
  module Common

    def current_time
      Time.zone.now
    end

    def result_struct(now, hash)
      caluculator = Struct.new(:now, :on, :off, :wait_time)
      caluculator.new(now, hash[:on], hash[:off], hash[:wait_time])
    end
  end
end


