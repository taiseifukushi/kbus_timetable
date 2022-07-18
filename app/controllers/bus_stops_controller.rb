class BusStopsController < ApplicationController
  before_action :test_result_struct_index, only: %i[index]
  before_action :get_bus_stop_obj, only: %i[index]

  def index; end

  def search
    on  = search_params[:get_on]
    off = search_params[:get_off]
    if on && off
      p 'true'
      # 一時的にコメントアウト
      # result = BusStop.calculate_wait_time(on, off)
      # @caluculated = result_struct(current_time, mock_result_hash)

      @caluculated = test_result_struct
      flash.now[:notice] = '更新しました'
      # binding.prys
      render turbo_stream:
        turbo_stream.replace(
          "caluculated",
          partial: "caluculated"
        )
    else
      p 'false'
      @results = false
      flash[:notice] = '更新しました'
    end
  end

  def show
    
  end

  def search_params
    params.require(:bus_stop).permit(:get_on, :get_off)
  end

  def get_bus_stop_obj
    @bus_stop = BusStop.all
  end

  def current_time
    Time.zone.now
  end

  def result_struct(now, hash)
    caluculator = Struct.new(:now, :on, :off, :wait_time)
    caluculator.new(now, hash[:on], hash[:off], hash[:wait_time])
  end

  # mockの結果
  def mock_result_hash_index
    { on: nil, off: nil, wait_time: nil }
  end

  # mockの結果
  def test_result_struct_index
    @caluculated = result_struct(nil, mock_result_hash_index)
  end

  # mockの結果
  def mock_result_hash
    { on: "Aバス", off: "Bバス", wait_time: 10 }
  end

  def test_result_struct
    @caluculated = result_struct(current_time, mock_result_hash)
  end
end
