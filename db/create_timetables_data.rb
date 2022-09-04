class CsvGenerator
  require "csv"

  attr_reader :base_csv_path, :base_updated_csv_path

  def initialize
    @base_csv_path         = "doc/timetable.csv"
    @base_updated_csv_path = "doc/timetable_updated.csv"
  end

  def generate_csv(&header)
    CSV.open(@base_updated_csv_path, "wb") do |csv|
      read_csv_file(@base_csv_path).each do |row|
        csv << header.call
        csv << row
      end
    end
  end

  def read_csv_file(path)
    CSV.read(path, headers: true)
  end
end

simple_header = lambda do
  [
    "busstops_id",
    "order",
    "row",
    "get_on_time_hour",
    "get_on_time_minute",
    "stop_sequence",
    "arrival_time",
    "departure_time"
  ]
end
generator = CsvGenerator.new
generator.generate_csv(&simple_header)

# bundle exec ruby db/create_timetable_data.rb

# やりたいこと
- busstopsテーブルをつくる
- timetablesテーブルをつくる
