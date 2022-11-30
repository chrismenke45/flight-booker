class FlightsController < ApplicationController
  before_action :set_flight, only: %i[ show ]

  def index
    @date_options = Flight.distinct.order(date: :asc).pluck("date(arrival_time)")
    @airport_options = Airport.all.order(:code).map { |a| [a.code, a.id] }
    if params[:flight]
      @flights = Flight.includes(:arrival_airport, :departure_airport).where("departure_airport_id = ? AND arrival_airport_id = ?", flight_params[:departure_airport], flight_params[:arrival_airport]).day_of(DateTime.iso8601(flight_params[:date])).limit(50)
      @flight = Flight.new
    else
      @flight = Flight.new
      @flights = []
    end
  end

  def show
  end

  private

  def set_flight
    @flight = Flight.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def flight_params
    params.require(:flight).permit(:departure_airport, :arrival_airport, :date, :passengers)
  end

  #def flight_params
  # flight_params.each do |param|
  #  puts "yeeh"
  #end
end
