class BaseApisController < ApplicationController
  def index; end

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
end
