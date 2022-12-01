class BookingsController < ApplicationController
  def new
    @flight = Flight.find(params[:flight_id])
    #@passenger_count = params[:passenger_count].to_i || 1
    @booking = Booking.new
    params[:passenger_count].to_i.times { @booking.passengers.build }
  end

  def create
    #puts booking_params
    @booking = Booking.new(booking_params)
    if @booking.save
      flash.notice = "Flight #{@booking.flight.formatted_flight_number} successfully booked! A confirmation email has been sent to each passenger."
      redirect_to booking_path(@booking.id)
    else
      flash.now[:alert] = ""
      if @booking.errors[:'passengers.name'].include?("can't be blank") ||
         @booking.errors[:'passengers.email'].include?("can't be blank")
        flash.now[:alert] << "The highlighted fields cannot be left blank. "
      end
      if @booking.errors[:'passengers.email'].include?("has already been taken")
        flash.now[:alert] << "The highlighted email address has been taken by a user with a different name."
      end
      @flight = Flight.find(@booking.flight_id)
      render :new
    end
    #redirect_to root_url
  end

  def show
    @booking = Booking.find(params[:id])
    if @booking
      render :show
    else
      flash[:alert] = 'Sorry, the booking you\'re looking for does not exist.'
      redirect_to root_url
    end
  end

  def index
  end

  private

  def booking_params
    params.require(:booking).
      permit(:flight_id, passengers_attributes: [:id, :name, :email])
  end
end
