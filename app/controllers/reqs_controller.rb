class ReqsController < ApplicationController
  def index
    @test = params.to_s
    render :index
  end

  def create
    @test = params.to_s
    render :index
  end
end
