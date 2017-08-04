class VisitsController < ApplicationController
  before_action :authenticate_user!
  def index
    case state
    when /unlooked/
      send("get_#{state}")
    else
      get_other
    end
    if request.xhr?
      session[:concert_ids] += @visits.map(&:concert_id) if state != 'unlooked'
      render partial: 'visits/more', layout: false
      return
    end
    session[:concert_ids] = @visits.map(&:concert_id) if state != 'unlooked'
  end

  def set
    v = Visit.find(params[:id])
    v.send(params[:event] + "!")
    render json: {
      events: v.aasm.events.map do |e|
        {
          event: e.name,
          id: params[:id],
          human: I18n.t("activerecord.attributes.visit.event.#{e.name}"),
        }
      end,
    }
  rescue => e
    render json: {
      error: e.message,
      backtrace: e.backtrace,
      params: params.permit(:id, :event),
    }
  end

  private
  def state
    params[:state]
  end

  def get_unlooked
    @concerts = Concert.unlooked_for(current_user).
      where('date > ?', Time.now).order(:date).limit(10)
    @visits = Visit.unlooked_for! current_user, @concerts
    @visits.each(&:see!)
    session[:concert_ids]=nil
  end

  def get_other
    @visits = current_user.visits.joins(:concert).
      where(aasm_state: state).
      where('concerts.date >= ?', (params[:date_from] || Time.now)).
      where(*(params[:date_to] ? ['concerts.date =< ?', params[:date_to]] : [nil])).
      where(*(request.xhr? ? ['concerts.id NOT IN (?)', session[:concert_ids]] : [nil])).
      order('concerts.date').
      preload(:concert).preload(concert: [:hall]).limit(10)
  end
end
