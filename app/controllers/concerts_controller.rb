class ConcertsController < ApplicationController
  def index
    hs = City.first.halls.pluck(:id)
    @concerts = Concert.preload(:hall).where(hall_id: hs).
      preload(concert_tags: %i[composer piece performer]).
      where('date >= ?', (params[:date_from] || Time.now)).
      where(*(params[:date_to] ? ['date <= ?', params[:date_to]] : [nil])).
      order(:date).page(params[:page]).per(10)
    if user_signed_in?
      @visits = Visit.unlooked_for! current_user, @concerts
      @visits.select{|v| v.unlooked? }.each(&:see!)
      @visit_navbar = true
    end
    if request.xhr?
      render partial: 'more', layout: false
      return
    end
    #@map_data = @concerts.map(&:hall).uniq.map{|h| h.to_map.merge({name: h.name})}.to_json
  end

  def show
    @concert = Concert.find(params[:id])
    if user_signed_in?
      @visit = @concert.visits.find_or_create_by(user: current_user)
      @visit.see! if @visit.aasm_state == 'unlooked'
    end
  end

  private
  def concert_params
    params.slice(:hall)
  end
end
