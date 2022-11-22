class TimetableService

  # @params departure_at [String]
  def initialize(departure_at:, processed_current_time:)
    @departure_at = departure_at
    @processed_current_time = processed_current_time
  end
  
  # @return [Array]
  def call
    just_after_record
  end
  
  private
  
  attr_reader :departure_at
  attr_reader :processed_current_time
  
  # 直後N件の時刻表のレコードを返す。デフォルト値は3件
  # @params number [Integer] 返却するレコード数
  # @return [Hash] { stop_headsign: "ＪＲ王子駅行", arrival_time: "20:35:00", departure_time: "20:35:00"}
  def just_after_records(number: 3)
    stop_id = departure_at
    current_time = processed_current_time
    # 
  end

  # def processing_current_time
  # end

  # def current_time
  # end
end