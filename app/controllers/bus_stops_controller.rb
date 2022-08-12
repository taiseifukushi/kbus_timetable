class BusStopsController < ApplicationController
  include Caluculater::Base

  before_action :test_result_struct_index, only: %i[index]
  before_action :get_bus_stop_obj, only: %i[index]

  def index; end

  def search
    on  = search_params[:get_on]
    off = search_params[:get_off]
    # binding.pry
    if both_are_entered?(on, off)
      p "true"
      # 一時的にコメントアウト
      # result = BusStop.calculate_wait_time(on, off)
      # @caluculated = result_struct(current_time, mock_result_hash)

      @result = test_result_struct
      # @result = result_struct
      flash.now[:notice] = "更新しました"
      render turbo_stream: [
        turbo_stream.replace("caluculated", partial: "caluculated"),
        turbo_stream.update("flash", partial: "shared/flash")
      ]
    else
      p "false"
      flash.now[:alert] = "バス停を選択してください"
      render turbo_stream: turbo_stream.update("flash", partial: "shared/flash")
    end
  end

  def both_are_entered?(on, off)
    on.present? && off.present?
  end

  def search_params
    params.require(:bus_stop).permit(:get_on, :get_off)
  end

  def get_bus_stop_obj
    @bus_stop = BusStop.all
  end
end
