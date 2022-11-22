class BusstopsController < ApplicationController
  def index
    @busstops ||= Busstop.busstops_cache
    render :index
  end

  def search
    if stop_name_selected?
      @search_results = Util::TimetableService.new(stop_id: search_params[:get_on]).call
      flash.now[:notice] = t("views.flash.notice")
      render turbo_stream: [
        turbo_stream.replace("search_results", partial: "search_results"),
        turbo_stream.update("flash", partial: "shared/flash")
      ]
    else
      flash.now[:alert] = t("views.flash.alert")
      render turbo_stream: [
        turbo_stream.update("flash", partial: "shared/flash")
      ]
    end
  end

  private

  def stop_name_selected?
    !search_params[:get_on].nil?
  end

  def search_params
    params.permit(:get_on)
  end
end
