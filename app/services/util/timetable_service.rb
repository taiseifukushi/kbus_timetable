module Util
  class TimetableService
    
    # @params [String] busstopのid
    def initialize(stop_id:)
      @stop_id = stop_id
    end
    
    # @return [Array]
    def call
      processing_activetsv_relation(just_after_records)
    end
    
    private
    
    attr_reader :stop_id
    
    # @params [ActiveTsv::Relation]
    # @return [Array<Hash>]
    def processing_activetsv_relation(activetsv_relation)
      activetsv_relation.to_a.map do |record|
        hash = {}
        hash[:arrival_time]   = record[:arrival_time]
        hash[:departure_time] = record[:departure_time]
        hash[:stop_id]        = record[:stop_id]
        hash[:stop_name]      = Busstop.where(stop_id: record[:stop_id]).last.stop_name # #find_byがサポートされていないため、#whereで実装する。https://github.com/ksss/active_tsv/blob/master/lib/active_tsv/querying.rb
        hash
      end
    end

    # 直後N件の時刻表のレコードを返す
    # @return [Hash] { stop_headsign: "ＪＲ王子駅行", arrival_time: "20:35:00", departure_time: "20:35:00"}
    def just_after_records
      trip_id = search_close_to_record(stop_id)[:trip_id]
      Timetable.where(stop_id: stop_id, trip_id: trip_id)
    end
    
    # @params [String]
    # @return [Timetable]
    # Todo: 2分探索で書き変えたい
    # instance method Array#bsearch
    # https://docs.ruby-lang.org/ja/latest/method/Array/i/bsearch.html
    def search_close_to_record(stop_id)
      timetable = Timetable.where(stop_id: stop_id)
      
      timetable.min_by do |record|
        processed_arrival_time = processing_arrival_time(record[:arrival_time])
        (current_time - processed_arrival_time).abs
      end
    end
  
    def processing_arrival_time(arrival_time)
      Util::TimeProcessor.processing_arrival_time(arrival_time)
    end
    
    def current_time
      @current_time ||= Util::TimeProcessor.current_time
    end
  end
end