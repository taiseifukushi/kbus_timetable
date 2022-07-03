class Jikan < ApplicationRecord
    belings_to :station

    def self.call_calculate_wait_time(id, is_up)
        records = tuple_record_before_relay_point_relay_point(get_on_station_id, is_up)
        before_relay_point_time = fix_time(records[0])
        relay_point_time        = fix_time(records[1])
        wait_time               = (before_relay_point_time - relay_point_time).abs

        {
            close_to_time_get_on:   getting_on_record_now_time(id)
            is_wait_time:           true,
            wait_time:              wait_time
        }
    end

    def self.non_wait_time(id)
        {
            close_to_time_get_on:   getting_on_record_now_time(id)
            is_wait_time:           false,
            wait_time:              0
        }
    end

    private

    def tuple_record_before_relay_point_relay_point(get_on_station_id, is_up)
        if is_up[:up]
            relay_point = RELAY_POINT[:up]
        else
            relay_point = RELAY_POINT[:down]
        end

        close_to_record    = getting_on_record_now_time(get_on_station_id)
        row                = close_to_record[:row]
        before_relay_point = relay_point[0]
        relay_point        = relay_point[1]
        before_relay_point_record       = Jikan.where(name: before_relay_point).find_by(row: row)
        relay_point_id                  = Station.find_by(name: relay_point)[:id]
        _before_relay_point_get_off_fixed_time  = fix_time(_record)

        relay_point_record = getting_on_record_select_time(relay_point_id, _before_relay_point_get_off_fixed_time)
        [before_relay_point_record, relay_point_record]
    end

    def getting_on_record_select_time(station_id, time)
        records = Jikan.where(station_id: station_id) # 駅のレコードが出てくる
                       .where(get_on_time_hour: time.hour) # 時間で絞る
        last_record = fix_last_record(records)

        if time < last_record
            close_to_record = records.min_by do |record|
                fix_minute = fix_record_minute(record)
                (fix_minute - time.minute).abs
            end
        else
            close_to_record = Jikan.where(station_id: station_id)
                                   .where(get_on_time_hour: time.hour + 1)
                                   .first
        end
    end

    def getting_on_record_now_time(station_id)
        time = current_time
        records = Jikan.where(station_id: station_id) # 駅のレコードが出てくる
                       .where(get_on_time_hour: time.hour) # 時間で絞る
        last_record = fix_last_record(records)

        if time < last_record
            close_to_record = records.min_by do |record|
                fix_minute = fix_record_minute(record)
                (fix_minute - time.minute).abs
            end
        else
            close_to_record = Jikan.where(station_id: station_id)
                                   .where(get_on_time_hour: time.hour + 1)
                                   .first
        end
    end

    def fix_last_records(records)
        Time.new(
            Time.now.year,
            records.last[:get_on_time_minute] <= 60 ? records.last[:get_on_time_hour] : records.last[:get_on_time_hour] + 1
            records.last[:get_on_time_minute] <= 60 ? records.last[:get_on_time_minute] : records.last[:get_on_time_minute] - 60
        )
    end

    def fix_record_minute(record)
        records[:get_on_time_minute] <= 60 ? record[:get_on_time_minute] : record[:get_on_time_minute] - 60
    end

    def fix_time(record)
        Time.new(
            Time.now.year,
            record[:get_on_time_minute] <= 60 ? record[:get_on_time_hour] : record[:get_on_time_hour] + 1
            record[:get_on_time_minute] <= 60 ? record[:get_on_time_minute] : record[:get_on_time_minute] - 60
        )
    end

    def current_time
        Time.zone.now
    end
end
