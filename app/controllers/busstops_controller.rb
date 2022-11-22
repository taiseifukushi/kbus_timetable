class BusstopsController < ApplicationController
  def index
    @busstops ||= Busstop.busstops_cache
    render :index
  end

  def search
    binding.pry
    @search_result = Timetable::TimetableService.new(stop_id: search_params[:get_on]).call
    flash.now[:notice] = "更新しました"
    render turbo_stream: [
      turbo_stream.replace("search_result", partial: "search_result"),
      turbo_stream.update("flash", partial: "shared/flash")
    ]
  end

  private

  def search_params
    params.permit(:get_on)
  end
end
