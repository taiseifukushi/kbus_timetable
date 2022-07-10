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
  [16, 36, 55], # ここまで正しい
  [16, 36, 55], # 以降は適当なデータ。とりあえず数だけ合わせている。
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55]
]

MAIJI_LIST_TABATA = [
  [15, 35, 55],
  [16, 36, 55], # ここまで正しい
  [16, 36, 55], # 以降は適当なデータ。とりあえず数だけ合わせている。
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55],
  [16, 36, 55]
]

SIHATU_HOUR = 7
SAISHUU_HOUR = 19

def repeat_counts
  SAISHUU_HOUR - SIHATU_HOUR + 1
end

def zipping_list(staions, maiji_lists)
  # [['霜降橋', false, 55], ..., ..., ]こういう配列を返したい
  zipped = staions.zip(maiji_lists)

  zipped.each_with_object([]) do |value, arg|
    bus_stop_set = value[0]
    jikan_set = value[1]

    jikan_set.map do |v|
      arg << bus_stop_set + [v]
    end
  end
end

def create_bus_stop(routes)
  type = routes == OJI_ROUTE ? 'Oji' : 'Tabata'
  klass = Module.const_get(type)
  routes.map do |route|
    klass.create(
      name: route[0],
      is_relay_point: route[1]
    )
  end
end

def find_bus_stop_id(name)
  BusStop.find_by(name:).id
end

def create_jikokuhyo(zipped_lists, _route)
  zipped_lists.each_with_index do |list, index|
    # [['霜降橋', false, 55], ..., ..., ]の形で受け取る
    name            = list[0]
    is_relay_point  = list[1]
    minute          = list[2]

    repeat_counts.times do |count|
      Jikan.create(
        bus_stop_id: find_bus_stop_id(name),
        order: index,
        get_on_time_hour: count + 6, # 6を足すことで時間を指定する
        get_on_time_minute: minute,
        row: count
      )
    end
  end
end

# ==========
oji_zipping_list     = zipping_list(OJI_ROUTE, MAIJI_LIST_OJI)
tabata_zipping_list  = zipping_list(TABATA_ROUTE, MAIJI_LIST_TABATA)

create_bus_stop(OJI_ROUTE)
create_bus_stop(TABATA_ROUTE)
create_jikokuhyo(oji_zipping_list, OJI_ROUTE)
create_jikokuhyo(tabata_zipping_list, TABATA_ROUTE)
