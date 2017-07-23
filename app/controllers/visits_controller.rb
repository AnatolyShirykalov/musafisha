class VisitsController < ApplicationController
  before_action :authenticate_user!
  def index
    state = params[:state]
    if state == 'unlooked'
      Concert.where.not(id: current_user.visits.pluck(:concert_id)).each do |c|
        current_user.visits.create concert: c
      end
    end
    @visits = current_user.visits.
      where(aasm_state: state).
      preload(:concert).
      page(params[:page]).per(20)
    @visits.each(&:see!) if state == 'unlooked'
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
end
