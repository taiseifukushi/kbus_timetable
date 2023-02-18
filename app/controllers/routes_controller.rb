class RoutesController < ApplicationController
  def index
    @routes ||= Route.busstops_cache
    render :index
  end

  def search
    if stop_name_selected?
      @search_results = Util::TimetableService.new(stop_id: search_params[:get_on]).call
      render turbo_stream: turbo_stream.replace("search_results", partial: "search_results")
    else
      @search_results = false
      render turbo_stream: turbo_stream.replace("search_results", partial: "search_results")
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
