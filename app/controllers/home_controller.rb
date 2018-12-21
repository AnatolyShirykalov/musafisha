class HomeController < ApplicationController
  def index
    if signed_in?
      state = current_user.visits.where(aasm_state: :go).first ? :go : :unlooked
      redirect_to visits_path(state: state) and return
    else
      redirect_to concerts_path and return
    end
  end
end
