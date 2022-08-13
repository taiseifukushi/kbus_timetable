class Jikan < ApplicationRecord
  belongs_to :bus_stop

  class << self
    def wait_time_hash(get_on_bus_stop_id, get_off_bus_stop_id, relay_points)
      get_on_record = record_boarding_time(get_on_bus_stop_id, current_time)
      relay_point_record = record_relay_point_boarding_time(get_on_bus_stop_id, get_on_record)
      get_off_record = record_get_off_time(get_off_bus_stop_id, get_on_record)
      build_time_get_on = adjustment_time_sixty_minute_records(relay_point_record[0])
      build_time_get_off = adjustment_time_sixty_minute_records(relay_point_record[1])

      wait_time = wait_time(build_time_get_on, build_time_get_off)
      hash = build_result_hash(relay_point_record[0], relay_point_record[1], build_time_get_on, build_time_get_off, wait_time)
      set_caluculation_result_struct(formate_current_time, hash)
    end

    private

    def record_boarding_time(get_on_id, current_time)
      # 乗る時間のレコードを見つける
      the_hour_records = Jikan.where(bus_stop_id: get_on_id).where(get_on_time_hour: current_time.hour)
      the_adjustment_hour_records = adjustment_time_sixty_minute_records(the_hour_records)

      record_boarding_time = the_adjustment_hour_records.min_by do |record|
        (record[:time] - current_time).abs
      end
      Jikan.find(record_boarding_time[:jikan_record_id])
    end

    def record_relay_point_boarding_time(relay_points, get_on_record)
      # 中継地点で降りる/乗る時間のレコードを探す
      relay_point_off = relay_points[0]
      relay_point_on = relay_points[1]
      
      the_hour_records = Jikan.where(row: get_on_record[:row]).where(order: get_on_record[:order])
      [off.where(name: relay_point_off)[0], on.where(name: relay_point_on)[0]]
    end
    
    def record_get_off_time(get_off_id, get_on_record)
      # 目的のバス停で降りる時間のレコードを探す
      the_hour_record = Jikan.where(row: get_on_record[:row]).where(order: get_on_record[:order]).find_by(bus_stop_id: get_off_id)[0]
    end

    # DBに保存していた60分加算していたレコードを現実時間と比較できるように調整
    # 15時82分 => 16時22分
    def adjustment_time_sixty_minute_records(the_hour_records)
      adjustment_time = Struct.new(:jikan_record_id, :time)
      the_hour_records.map do |record|
        # record[:get_on_time_minute] <= 60 ? record[:get_on_time_minute] : record[:get_on_time_minute] + 60
        if record[:get_on_time_minute] <= 60
          time = Time.new(Time.now.year, record[:get_on_time_hour], records[:get_on_time_minute])
          adjustment_time.new(record[:id], time)
        else
          time = Time.new(Time.now.year, record[:get_on_time_hour] + 1 , records[:get_on_time_minute] - 60)
          adjustment_time.new(jikan_record_id[:id], time)
        end
      end
    end

    def wait_time(relay_point_off_time, relay_point_on_time)
      (relay_point_off_time - relay_point_on_time).abs
    end

    def build_result_hash(relay_point_off, relay_point_on, get_on, get_off, wait_time)
      {
        relay_point_off: relay_point_off,
        relay_point_on: relay_point_on,
        get_on: get_on,
        get_off: get_off,
        wait_time: wait_time
      }
    end

    def current_time
      Time.zone.now
    end

    def formate_current_time
      current_time.strftime("%m月/%d日 %H時:%M分:%S秒")
    end

    def set_caluculation_result_struct(time, hash)
      caluculator = Struct.new(
        :current_time,
        :relay_point_off,
        :relay_point_on,
        :get_on,
        :get_off,
        :wait_time
      )
      caluculator.new(
        time,
        hash[:relay_point_off],
        hash[:relay_point_on],
        hash[:get_on],
        hash[:get_off],
        hash[:wait_time]
      )
    end
  end
end
