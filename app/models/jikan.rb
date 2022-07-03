class Jikan < ApplicationRecord
    belings_to :station

    def self.call_calculate_wait_time(id, is_up)
        record_relay_point = get_off_time_before_relay_point(get_on_station_id, is_up)

        {
            close_to_time_get_on:   close_to_time_get_on(id),
            is_wait_time:           true,
            wait_time:              wait_time
        }
    end

    def self.close_to_time_get_on(id)
        getting_on_record(id)
    end

    private

    def get_off_time_before_relay_point(get_on_station_id, is_up)
        if is_up[:up]
            relay_point = RELAY_POINT[:up]
        else
            relay_point = RELAY_POINT[:down]
        end

        close_to_record    = getting_on_record(get_on_station_id)
        row                = close_to_record[:row]
        before_relay_point = relay_point[0]
        _record            = Jikan.where(name: before_relay_point).find_by(row: row)
        _time              = fix_time(_record)

        getting_on_record_relay_point(_record[:station_id], _time)
    end

    def getting_on_record_relay_point(station_id, time)
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

    def getting_on_record(station_id)
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
