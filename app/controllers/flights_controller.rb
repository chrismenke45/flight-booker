class FlightsController < ApplicationController
  before_action :set_flight, only: %i[ show ]

  def index
    @date_options = Flight.distinct.order(date: :asc).pluck("date(arrival_time)")
    @date_options.unshift(["Departure Date", "0"])
    @departure_options = Airport.all.order(:code).map { |a| [a.code, a.id.to_s] }
    @arrival_options = @departure_options.dup
    if params[:flight_query]
      @flights = Flight.includes(:arrival_airport, :departure_airport).where("departure_airport_id = ? AND arrival_airport_id = ?", flight_query_params[:departure_airport], flight_query_params[:arrival_airport]).day_of(DateTime.iso8601(flight_query_params[:date])).limit(50)
      @flight_query = FlightQuery.new(flight_query_params)
    else
      @flight_query = FlightQuery.new
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
  def flight_query_params
    params.require(:flight_query).permit(:departure_airport, :arrival_airport, :date, :passengers)
  end

  #def flight_params
  # flight_params.each do |param|
  #  puts "yeeh"
  #end
end
