class ConcertsController < ApplicationController
  def index
    @concerts = Concert.where(concert_params).page(params[:page]).per(20)
  end

  def show
    @concert = Concert.find(params[:id])
  end

  private
  def concert_params
    params.slice(:hall)
  end
end
