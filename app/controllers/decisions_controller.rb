class DecisionsController < ApplicationController
  def index
    binding.pry
    @visits = User.find(params[:user_id]).where(aasm_state: params[:state]).
      visits.preload(:concert).page(params[:page]).per(20)
    @my_visits = Visits.where(user: current_user, concert_id: @visits.map{|v| v.concert.id})
  end
end
