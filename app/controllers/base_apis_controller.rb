class BaseApisController < ApplicationController
  def index
  end

  def search
    # 検索処理をして結果を返す
    json = {
      "test": "hoge"
    }
    render :json => json
  end
end
