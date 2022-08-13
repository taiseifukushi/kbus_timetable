class BusStop < ApplicationRecord
  has_many :jikan

  OJI_ROUTE = %w[
    JR王子駅1
    王子本町交番
    障害者福祉センター
    中央図書館
    王子アパート
    紅葉橋
    北区役所
    飛鳥山公園1
    一里塚1
    花と森の東京病院1
    旧古河庭園1
    滝野川小学校1
    霜降橋1
    JR駒込駅
    霜降橋2
    滝野川小学校2
    旧古河庭園2
    花と森の東京病院2
    一里塚2
    飛鳥山公園2
    JR王子駅2
  ].freeze

  TABATA_ROUTE = %w[
    JR駒込駅
    駒込一丁目
    田端三丁目
    田端区民センター
    田端二丁目
    JR田端駅
    田端五丁目
    富士見橋エコー広場館
    中里保育園
    女子聖学院
    滝野川会館
    滝野川小学校
    霜降橋
  ].freeze

  RELAY_POINT = {
    # 上り
    up: %w[
      JR駒込駅
      JR駒込駅
    ],
    # 下り
    down: %w[
      滝野川会館
      旧古河庭園2
    ]
  }.freeze

  class << self
    def calculate_wait_time(on, off)
      get_on_bus_stop_id = BusStop.find_by(name: on).id
      get_off_bus_stop_id = BusStop.find_by(name: off).id
      if norikae?(on, off)
        Jikan.wait_time_hash(get_on_bus_stop_id, get_on_bus_stop_id, relay_points(on))
      else
        non_wait_time_hash
      end
    end

    private

    def norikae?(on, off)
      !(OJI_ROUTE.include?(on) == OJI_ROUTE.include?(off))
    end

    def relay_points(on)
      OJI_ROUTE.include?(on) ? RELAY_POINT[:up] : RELAY_POINT[:down]
    end

    def non_wait_time_hash
      { relay_point: nil, wait_time: false }
    end
  end
end
