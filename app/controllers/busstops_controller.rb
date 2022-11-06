class BusstopsController < ApplicationController
  def index
    @busstops ||= Busstop.busstops_cache
  end

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
