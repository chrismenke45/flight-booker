class PassengerMailer < ApplicationMailer
  default from: "chrismenke45test@gmail.com"

  def confirmation_email
    @passenger = params[:passenger]
    @booking = params[:booking]
    @url = "http://example.com/login"
    mail(to: @passenger.email, subject: "Confirmation for your flight")
  end
end
