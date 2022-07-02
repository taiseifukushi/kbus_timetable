class Station < ApplicationRecord
    has_many: jikan


    # 動的に時間を生成
    # 分は固定
    # 始発と終わりが決まっている
end
