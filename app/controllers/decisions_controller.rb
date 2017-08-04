class DecisionsController < ApplicationController
  def index
    @visits = Visit.joins(:concert).
      where(aasm_state: params[:state], user_id: params[:user_id]).
      where('concerts.date >= ?', (params[:date_from] || Time.now)).
      where(*(params[:date_to] ? ['concerts.date <= ?', params[:date_to] ] : [nil])).
      preload(concert: [:hall]).page(params[:page]).per(10)
    @my_visits = Visit.where(user: current_user, concert_id: @visits.map{|v| v.concert.id}).to_a
    if request.xhr?
      render partial: 'more', layout: false
      return
    end
  end

  def show
    @visit = Visit.preload(concert: [:hall]).find_by_id(params[:id])
    if user_signed_in?
      @my_visit = Visit.find_or_create_by(concert: @visit.concert,
                                          user: current_user)
    end
  end
end
