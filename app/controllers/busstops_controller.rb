class BusstopsController < ApplicationController

  # before_action :initial_odj, only: %i[index]
  # before_action :busstop_list, only: %i[index]

  # def index; end

  # def search
  #   on = search_params[:get_on]
  #   off = search_params[:get_off]
  #   if both_are_entered?(on, off)
  #     @caluculation = calculate_wait_time(on, off)
  #     flash.now[:notice] = "更新しました"
  #     render turbo_stream: [
  #       turbo_stream.replace("caluculation_result", partial: "caluculation_result"),
  #       turbo_stream.update("flash", partial: "shared/flash")
  #     ]
  #   else
  #     flash.now[:alert] = "バス停を選択してください"
  #     render turbo_stream: [
  #       turbo_stream.replace("both_are_not_entered", partial: "both_are_not_entered"),
  #       turbo_stream.update("flash", partial: "shared/flash")
  #     ]
  #   end
  # end

  # def both_are_entered?(on, off)
  #   on.present? && off.present?
  # end

  # def busstop_list
  #   @busstop = Busstop.all
  # end

  # def calculate_wait_time(on, off)
  #   @caluculation = Busstop.calculate_wait_time(on, off)
  # end

  # def initial_odj
  #   @caluculation = { relay_point: nil, wait_time: false }
  # end

  # def search_params
  #   params.require(:busstop).permit(:get_on, :get_off)
  # end
end
