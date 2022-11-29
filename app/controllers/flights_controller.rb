class FlightsController < ApplicationController
  before_action :set_flight, only: %i[ show ]

  def index
  end

  def show
  end

  def set_flight
    @flight = Flight.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  #def event_params
  # params.require(:flight).permit(:name, :description, :date)
  #end
end
