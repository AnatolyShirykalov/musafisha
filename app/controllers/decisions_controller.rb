class DecisionsController < ApplicationController
  def index
    @visits = User.find_by(slug: params[:user]).visits.joins(:concert).
      where(aasm_state: params[:state]).
      where('concerts.date >= ?', (params[:date_from] || Time.now)).
      where(*(params[:date_to] ? ['concerts.date <= ?', params[:date_to] ] : [nil])).
      preload(concert: [:hall]).order('concerts.date').
      page(params[:page]).per(10)
    @my_visits = Visit.where_or_create!(user: current_user, concerts: @visits.map(&:concert))
    @my_visits.each do |visit|
      visit.see! if visit.aasm_state == 'unlooked'
    end
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
