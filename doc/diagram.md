# 図

## アクティビティ図
>開始ノード「●」と終了ノード「◉」を記載し、その間に処理を矢印でつないで記載し、必要に応じて分岐などを記載する。 ステートマシン図と異なり、角丸長方形に書くのは（状態ではなく）処理や動作であることに注意。
https://ja.wikipedia.org/wiki/%E3%82%A2%E3%82%AF%E3%83%86%E3%82%A3%E3%83%93%E3%83%86%E3%82%A3%E5%9B%B3

```mermaid
stateDiagram
    [*]
    state if_state <<choice>>
    [*] --> 乗降するバス停、時間を選択
    乗降するバス停、時間を選択 --> 乗換が発生するか
    乗換が発生するか --> if_state
    if_state --> 待ち時間を<br>計算: yes
    if_state --> 待ち時間は<br>発生しないという<br>結果を画面に表示する: no
    待ち時間は<br>発生しないという<br>結果を画面に表示する --> 再計算をするか

    待ち時間を<br>計算 --> 計算結果を<br>画面に表示する: 計算結果を返却

    state retry <<choice>>
    計算結果を<br>画面に表示する --> 再計算をするか
    再計算をするか --> retry
    retry --> 乗降するバス停、時間を選択: yes
    retry --> [*]: no
```

## ER図
>実体関連モデル（またはERモデル）は、特定の知識領域で相互に関連する関心事を記述します。基本的なERモデルは、エンティティタイプ（関心のあるものを分類する）で構成され、エンティティ（それらのエンティティタイプのインスタンス）間に存在できる関係を指定します。ウィキペディア。
https://mermaid-js.github.io/mermaid/#/entityRelationshipDiagram

```mermaid
erDiagram
    BUS_STOP ||--|{ TIMETABLE: ""

    BUS_STOP {
        int id PK
        string name
        boolean is_relay_point
        string type
    }
    TIMETABLE {
        int id PK
        int busstop_id FK
        int get_on_time_hour
        int get_on_time_minute
        int order
        int row
    }
```
