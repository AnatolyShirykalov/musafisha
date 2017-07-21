class HallsController < ApplicationController
  def index
    @halls = Hall.where(hall_params).page(params[:page]).per(20)
  end

  def show
    @hall = Hall.find(params[:id])
  end

  private
  def hall_params
    params.permit(:id)
  end
end
