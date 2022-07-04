OJI_ROUTE = [
  ['JR王子駅1', false],
  ['王子本町交番', false],
  ['障害者福祉センター', false],
  ['中央図書館', false],
  ['王子アパート', false],
  ['紅葉橋', false],
  ['北区役所', false],
  ['飛鳥山公園1', false],
  ['一里塚1', false],
  ['花と森の東京病院1', false],
  ['旧古河庭園1', false],
  ['滝野川小学校1', false],
  ['霜降橋1', false],
  ['JR駒込駅', true],
  ['霜降橋2', false],
  ['滝野川小学校2', false],
  ['旧古河庭園2', true],
  ['花と森の東京病院2', false],
  ['一里塚2', false],
  ['飛鳥山公園2', false],
  ['JR王子駅2', false]
]

TABATA_ROUTE = [
  ['JR駒込駅', true],
  ['駒込一丁目', false],
  ['田端三丁目', false],
  ['田端区民センター', false],
  ['田端二丁目', false],
  ['JR田端駅', false],
  ['田端五丁目', false],
  ['富士見橋エコー広場館', false],
  ['中里保育園', false],
  ['女子聖学院', false],
  ['滝野川会館', true],
  ['滝野川小学校', false],
  ['霜降橋', false]
]

MAIJI_LIST_OJI = [
  [15, 35, 55],
  [16, 36, 55]
]

MAIJI_LIST_TABATA = [
  [15, 35, 55],
  [16, 36, 55]
]

SIHATU_HOUR = 7
SAISHUU_HOUR = 19

def create_jkokuhyo(staions, maiji_list)
  maiji_list.each_with_index do |maiji, _index|
    # [15, 35, 55]
    maiji.each_with_index do |min, idx|
      # min 15
      repeat_counts.times do |count|
        staions.each_with_index do |station, _i|
          oji_station = Oji.create(
            name: station[0],
            is_relay_point: station[1]
          )
          at_time = count + 6
          Jikan.create(
            station_id: oji_station[:id],
            order: idx,
            get_on_time_hour: at_time,
            get_on_time_minute: min,
            row: count
          )
        end
      end
    end
  end
end

def repeat_counts
  SAISHUU_HOUR - SIHATU_HOUR + 1
end

create_jkokuhyo(OJI_ROUTE, MAIJI_LIST_OJI)
create_jkokuhyo(TABATA_ROUTE, MAIJI_LIST_TABATA)
