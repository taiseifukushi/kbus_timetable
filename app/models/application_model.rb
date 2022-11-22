# require 'active_csv'

class ApplicationModel
  # class ApplicationModel < ActiveCsv::Base
  include ActiveModel::Model
  # self.table_pathは、各モデルで指定する
  # self.table_path = "data/csv/timetable.csv"
end
