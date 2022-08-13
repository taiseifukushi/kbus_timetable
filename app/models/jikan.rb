class Jikan < ApplicationRecord
  belongs_to :bus_stop

  class << self
    def wait_time_hash(get_on_bus_stop_id, get_off_bus_stop_id, relay_points)
      get_on_record      = record_boarding_time(get_on_bus_stop_id, current_time)
      relay_point_records = record_relay_point_boarding_time(relay_points, get_on_record)
      get_off_record     = record_get_off_time(get_off_bus_stop_id, get_on_record)
      build_time_get_on_struct  = adjustment_time_sixty_minute_record(relay_point_records[0])
      build_time_get_off_struct = adjustment_time_sixty_minute_record(relay_point_records[1])

      wait_time          = wait_time(build_time_get_on_struct, build_time_get_off_struct)
      hash               = build_result_hash(relay_point_records[0], relay_point_records[1], build_time_get_on, build_time_get_off, wait_time)
      set_caluculation_result_struct(formate_current_time, hash)
    end

    private
    
    def record_boarding_time(get_on_id, current_time)
      # 乗る時間のレコードを見つける
      the_hour_records = Jikan.where(bus_stop_id: get_on_id).where(get_on_time_hour: current_time.hour)
      close_to_record = search_close_to_record(the_hour_records)
    end

    def record_relay_point_boarding_time(relay_points, get_on_record)
      # 中継地点で降りる/乗る時間のレコードを探す
      relay_point_off_id = BusStop.find_by(name: relay_points[0])[:id]
      relay_point_on_id = BusStop.find_by(name: relay_points[1])[:id]

      same_row = Jikan.where(row: get_on_record[:row])
      the_hour_records_relay_point_off = same_row.where(bus_stop_id: relay_point_off_id)
      the_hour_records_relay_point_on = same_row.where(bus_stop_id: relay_point_on_id)

      record_relay_point_off = search_close_to_record(the_hour_records_relay_point_off)
      record_relay_point_on = search_close_to_record(the_hour_records_relay_point_on)

      [record_relay_point_off, record_relay_point_on]
    end

    def record_get_off_time(get_off_id, get_on_record)
      # 目的のバス停で降りる時間のレコードを探す
      binding.pry
      the_hour_records = Jikan.where(bus_stop_id: get_off_id).where(row: get_on_record[:row])
    end

    def search_close_to_record(records)
      the_adjustment_hour_records = adjustment_time_sixty_minute_records(records)
      record_close_to_time = the_adjustment_hour_records.min_by do |record|
        (record[:time] - current_time).abs
      end
      # binding.pry
      Jikan.find(record_close_to_time[:jikan_record_id])
    end

    # DBに保存していた60分加算していたレコードを現実時間と比較できるように調整
    # 15時82分 => 16時22分
    def adjustment_time_sixty_minute_records(the_hour_records)
      adjustment_time = Struct.new(:jikan_record_id, :time)
      the_hour_records_to_a = the_hour_records.pluck(:id, :get_on_time_hour, :get_on_time_minute)
      the_hour_records_to_a.each_with_object([]) do |record, array|
        if record[2] <= 60
          time = Time.new(Time.now.year, Time.now.mon, Time.now.day, record[1], record[2], 0, "+09:00")
          array << adjustment_time.new(record[0], time)
        else
          time = Time.new(Time.now.year, Time.now.mon, Time.now.day, record[1] + 1, record[2] - 60, 0, "+09:00")
          array << adjustment_time.new(record[0], time)
        end
      end
    end

    def adjustment_time_sixty_minute_record(the_hour_record)
      adjustment_time = Struct.new(:jikan_record_id, :time)
      if the_hour_record[:get_on_time_minute] <= 60
        time = Time.new(Time.now.year, Time.now.mon, Time.now.day, the_hour_record[:get_on_time_hour], the_hour_record[:get_on_time_minute], 0, "+09:00")
        adjustment_time.new(the_hour_record[:id], time)
      else
        time = Time.new(Time.now.year, Time.now.mon, Time.now.day, the_hour_record[:get_on_time_hour] + 1, the_hour_record[:get_on_time_minute] - 60, 0, "+09:00")
        adjustment_time.new(the_hour_record[:id], time)
      end
    end

    def wait_time(relay_point_on_time_struct, relay_point_off_time_struct)
      (relay_point_on_time_struct[:time] - relay_point_off_time_struct[:time]).abs
    end

    def build_result_hash(relay_point_off, relay_point_on, get_on, get_off, wait_time)
      {
        relay_point_off:,
        relay_point_on:,
        get_on:,
        get_off:,
        wait_time:
      }
    end

    def current_time
      if Time.now.hour >= 20
        Time.new(Time.now.tomorrow.year, Time.now.tomorrow.mon, Time.now.tomorrow.day, 7, 0, 0, "+09:00")
      else
        Time.now
      end
    end

    def formate_current_time
      Time.zone.now.strftime("%m/%d %H:%M:%S")
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
