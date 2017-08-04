class ConcertsController < ApplicationController
  def index
    hs = City.first.halls.pluck(:id)
    @concerts = Concert.preload(:hall).where(hall_id: hs).
      where('date >= ?', (params[:date_from] || Time.now)).
      where(*(params[:date_to] ? ['date <= ?', params[:date_to]] : [nil])).
      order(:date).page(params[:page]).per(10)
    if request.xhr?
      render partial: 'more', layout: false
      return
    end
    #@map_data = @concerts.map(&:hall).uniq.map{|h| h.to_map.merge({name: h.name})}.to_json
  end

  def show
    @concert = Concert.find(params[:id])
  end

  private
  def concert_params
    params.slice(:hall)
  end
end
