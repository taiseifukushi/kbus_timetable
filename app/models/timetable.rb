class Timetable < ApplicationRecord
  belongs_to :bus_stop

  class << self
    def wait_time_hash(get_on_bus_stop_id, get_off_bus_stop_id, relay_points)
      get_on_record                         = record_boarding_time(get_on_bus_stop_id, current_time)
      relay_point_records                   = record_relay_point_time(relay_points, get_on_record)
      get_off_record                        = record_get_off_time(get_off_bus_stop_id, get_on_record)
      build_time_arriving_relay_point_struct = adjustment_time_sixty_minute_record(relay_point_records[0])
      build_time_leaving_relay_point_struct = adjustment_time_sixty_minute_record(relay_point_records[1])
      wait_time                             = wait_time(build_time_arriving_relay_point_struct,
                                                        build_time_leaving_relay_point_struct)

      hash = build_result_hash(
        format_record_time(get_on_record),                          # :get_on_time
        format_strcut_time(build_time_arriving_relay_point_struct), # :arriving_relay_point_time
        wait_time,                                                  # :wait_time
        format_strcut_time(build_time_leaving_relay_point_struct),  # :leaving_relay_point_time
        format_record_time(get_off_record) # :get_off
      )
      set_caluculation_result_struct(format_current_time, hash)
    end

    private

    def record_boarding_time(get_on_id, current_time)
      # 乗る時間のレコードを見つける
      the_hour_records = Timetable.where(bus_stop_id: get_on_id).where(get_on_time_hour: current_time.hour)
      close_to_record = search_close_to_record(the_hour_records)
    end

    def record_relay_point_time(relay_points, get_on_record)
      # 中継地点で降りる/乗る時間のレコードを探す
      arriving_relay_point_id = BusStop.find_by(name: relay_points[0])[:id]
      leaving_relay_point_on_id = BusStop.find_by(name: relay_points[1])[:id]

      same_row = Timetable.where(row: get_on_record[:row])
      the_hour_records_arriving_relay_point = same_row.where(bus_stop_id: arriving_relay_point_id)
      the_hour_records_leaving_relay_point = same_row.where(bus_stop_id: leaving_relay_point_on_id)

      [the_hour_records_arriving_relay_point, the_hour_records_leaving_relay_point].map do |record|
        # the_hour_records が Timetable::ActiveRecord_Relation(Timetableクラス)の場合に、`search_close_to_record`を呼ぶ
        search_close_to_record(record) unless record.instance_of?(self)
      end
    end

    def record_get_off_time(get_off_id, get_on_record)
      # 目的のバス停で降りる時間のレコードを探す
      # binding.pry
      the_hour_records = Timetable.where(bus_stop_id: get_off_id).where(row: get_on_record[:row])
      # the_hour_records が Timetable::ActiveRecord_Relation(Timetableクラス)の場合に、`search_close_to_record`を呼ぶ
      search_close_to_record(the_hour_records) unless the_hour_records.instance_of?(self)
    end

    def search_close_to_record(records)
      the_adjustment_hour_records = adjustment_time_sixty_minute_records(records)
      record_close_to_time = the_adjustment_hour_records.min_by do |record|
        (record[:time] - current_time).abs
      end
      Timetable.find(record_close_to_time[:timetable_record_id])
    end

    # DBに保存していた60分加算していたレコードを現実時間と比較できるように調整
    # 15時82分 => 16時22分
    def adjustment_time_sixty_minute_records(the_hour_records)
      adjustment_time = Struct.new(:timetable_record_id, :time)
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
      adjustment_time = Struct.new(:timetable_record_id, :time)
      if the_hour_record[:get_on_time_minute] <= 60
        time = Time.new(Time.now.year, Time.now.mon, Time.now.day, the_hour_record[:get_on_time_hour],
                        the_hour_record[:get_on_time_minute], 0, "+09:00")
        adjustment_time.new(the_hour_record[:id], time)
      else
        time = Time.new(Time.now.year, Time.now.mon, Time.now.day, the_hour_record[:get_on_time_hour] + 1,
                        the_hour_record[:get_on_time_minute] - 60, 0, "+09:00")
        adjustment_time.new(the_hour_record[:id], time)
      end
    end

    def wait_time(relay_point_on_time_struct, relay_point_off_time_struct)
      (relay_point_on_time_struct[:time] - relay_point_off_time_struct[:time]).abs
    end

    def build_result_hash(get_on_time, arriving_relay_point_time, wait_time, leaving_relay_point_time, get_off_time)
      {
        get_on_time:,
        arriving_relay_point_time:,
        wait_time:,
        leaving_relay_point_time:,
        get_off_time:
      }
    end

    def current_time
      if Time.now.hour >= 20
        Time.new(Time.now.tomorrow.year, Time.now.tomorrow.mon, Time.now.tomorrow.day, 7, 0, 0, "+09:00")
      else
        Time.now
      end
    end

    def format_current_time
      Time.zone.now.strftime("%H:%M:%S")
    end

    def format_strcut_time(jikan_struct)
      jikan_struct[:time].strftime("%H:%M:%S")
    end

    def format_record_time(jikan_record)
      # binding.pry
      t = Time.new(Time.now.year, Time.now.mon, Time.now.day, jikan_record[:get_on_time_hour],
                   jikan_record[:get_on_time_hour], 0, "+09:00")
      t.strftime("%H:%M:%S")
    end

    def set_caluculation_result_struct(time, hash)
      caluculator = Struct.new(
        :current_time,
        :get_on_time,
        :arriving_relay_point_time,
        :wait_time,
        :leaving_relay_point_time,
        :get_off_time
      )
      caluculator.new(
        time,
        hash[:get_on_time],
        hash[:arriving_relay_point_time],
        hash[:wait_time],
        hash[:leaving_relay_point_time],
        hash[:get_off_time]
      )
    end
  end
end
