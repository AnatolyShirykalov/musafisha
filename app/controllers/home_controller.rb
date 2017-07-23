class HomeController < ApplicationController
  def index
    if signed_in?
      redirect_to '/concerts/unlooked' and return
    else
      redirect_to '/concerts' and return
    end
  end
end
