module TimetableService
  extend ActiveSupport::Concern

  enum :stop_headsign {
    "富士見橋エコー広場館行",
    "ＪＲ駒込駅行",
    "北区役所行",
    "ＪＲ王子駅行"
  }

  module ClassMethods
    def search_departure_time(get_on:, get_off:)
      # raise NotImplementedError
    end
    
    def search_arrival_time(get_on:, get_off:)
      raise NotImplementedError
    end
    
    def search_waiting_time_at_relay_point(get_on:, get_off:)
      raise NotImplementedError
    end
    
    def require_relay?(get_on:, get_off:)
      raise NotImplementedError
    end

    private

    def current_time
      Time.zone.now.strftime("%T")
    end

    def current_time_
      Time.zone.now
    end

    def headsign(get_on:, get_off:)
      # "S20" ~ "S26" =>  "富士見橋エコー広場館行",

      # "S27" ~ "S30" =>  "ＪＲ駒込駅行",
      # "S16", "S18", "S20" =>  "ＪＲ駒込駅行",

      # "S7" ~ "S20" =>  "北区役所行",
      # "S20" ~ "S20" =>  "ＪＲ王子駅行",
    end
  end
end