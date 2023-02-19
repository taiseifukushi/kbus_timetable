require "csv"

busstops_csv_path     = "db/source_data/csv/busstops.csv"
timetable_csv_path    = "db/source_data/csv/timetable.csv"
busstops_csv          = CSV.read(busstops_csv_path)
timetable_csv         = CSV.read(timetable_csv_path)
busstops_column       = busstops_csv.first
timetable_column      = timetable_csv.first
extract_busstops_csv  = busstops_csv.drop(1)
extract_timetable_csv = timetable_csv.drop(1)

Busstop.import(busstops_column, extract_busstops_csv)

extract_timetable_csv.map do |row|
  stop_id = row[3]
  row << Busstop.find_by(stop_id: stop_id).id
end

timetable_column.push("busstop_id")

Timetable.import(timetable_column, extract_timetable_csv)
