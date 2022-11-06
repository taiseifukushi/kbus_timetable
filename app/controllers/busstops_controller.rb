class BusstopsController < ApplicationController
  def index
    @busstops ||= Busstop.busstops_cache
    # binding.pry
  end

  def test
    binding.pry
    @test = params[:action]
  end
  # curl -X POST -H "Content-Type: application/json" -d "{"name" : "佐藤" , "mail" : "sato@example.com"}" https://27e1-2409-10-a080-100-ed4b-a847-86b8-f613.ngrok.io/

  def search
    @search_result = search_departure_time(search_params[:get_on], search_params[:get_off])
    flash.now[:notice] = "更新しました"
    render turbo_stream: [
      turbo_stream.replace("caluculation_result", partial: "caluculation_result"),
      turbo_stream.update("flash", partial: "shared/flash")
    ]
  end

  # @param [String]: 
  # @return [Array]: 
  def search_route()
    # 選択されたrouteのバス停を返す
  end

  private

  def search_departure_time(get_on:, get_off:)
    # TimetableService.search_departure_time(get_on, get_off)
  end

  def search_params
    params.require(:bus_stop).permit(:get_on, :get_off)
  end
end
