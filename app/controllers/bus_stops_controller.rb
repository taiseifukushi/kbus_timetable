class BusStopsController < ApplicationController
  # before_action :get_bus_stop_name

  def index
    @bus_stop = get_bus_stop_obj
  end

  def search
    # binding.pry
    if params
      # if search_params
      p 'true'
      result = Station.calculate_wait_time(params)
    else
      p 'false'
    end
    render turbo_stream: turbo_stream.append(result)
  end

  # def search_params
  #   params.require(:search).permit(:get_on, :get_off)
  # end

  def get_bus_stop_obj
    BusStop.all
    # BusStop.select("name")
    # BusStop.select("name").pluck(:name)
  end
end
