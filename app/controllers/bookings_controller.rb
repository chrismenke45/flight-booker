class BookingsController < ApplicationController
  def new
    @flight = Flight.find(params[:flight_id])
    #@passenger_count = params[:passenger_count].to_i || 1
    @booking = Booking.new
    params[:passenger_count].to_i.times { @booking.passengers.build }
  end

  def create
    puts booking_params
    redirect_to root_url
  end

  def show
  end

  def index
  end

  private

  def booking_params
    params.require(:booking).
      permit(:flight_id, passengers_attributes: [:name, :email])
  end
end
