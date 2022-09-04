# ADD_COLUMN = lambda do
#   ["order", "get_on_time_hour", "get_on_time_minute", "row"]
# end

class CsvOperator
  require "csv"
  require 'set'
  require 'pry'

  attr_reader :base_csv_path, :base_updated_csv_path

  def initialize
    @base_csv_path = "doc/data/busstops.csv"
  end

  def extract_header(path, &require_header)
    csv = read_csv_file(path)
    set = csv.headers.to_set & require_header.call.to_set
    set.to_a
  end

  def read_csv_file(path)
    CSV.read(path, headers: true)
  end
end

class MakeBusstopstable
  attr_reader :csv

  def initialize
    @csv = CsvOperator.new
  end

  def create_busstops_records(csv)
    csv.each do |row|
      create_busstops_record(row)
    end
  end

  def create_busstops_record(row)
    Busstop.create(
      is_relay_point: relay_point?(row),
      stop_id:        row["stop_id"],
      stop_name:      row["stop_name"], # ここに条件式を入れたい複数登録されているバス停には1, 2を入れたい
      stop_lat:       row["stop_lat"],
      stop_lon:       row["stop_lon"],
      zone_id:        row["zone_id"],
      location_type:  row["location_type"],
    )
  end

  # def convert_hour(time)
  #   time[0]
  # end
  
  # def convert_minute(time)
  #   time[1]
  # end

  # def split_time(record)
  #   "#{record}".split(/:/)
  # end

  def relay_point?(record)
    relay_point.include?(record)
  end

  def relay_point
    ["ＪＲ駒込駅", "旧古河庭園", "滝野川会館"].to_set
  end

  def extract_header
    csv.extract_header(csv.base_csv_path, &REQUIRE_CSV_HEADER)
  end

  def read_csv_file
    csv.read_csv_file(csv.base_csv_path)
  end
end

class MakeOjitable < MakeBusstopstable; end
class MakeTabatatable < MakeBusstopstable; end

REQUIRE_CSV_HEADER = lambda do
  ["arrival_time", "departure_time", "stop_id", "stop_sequence", "stop_headsign", "pickup_type", "drop_off_type"]
end

p "Create Oji Route"
oji_table = MakeOjitable.new
oji_table.create_busstops_records(oji_table.read_csv_file)
p "Finish Create Oji Route"

p "Create Tabata Route"
tabata_table = MakeTabatatable.new
tabata_table.create_busstops_records(tabata_table.read_csv_file)
p "Finish Create Tabata Route"

# docker compose run web bundle exec rails runner db/create_busstops_data.rb
# docker compose run web bundle exec rails db:drop db:create db:migrate
