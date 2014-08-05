class Admin::PilotsController < ApplicationController
  def index
  	@pilots = Pilot.all
  end
end
