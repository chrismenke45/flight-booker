class FlightQuery < ApplicationRecord
  validates :date, format: { with: regex = /\d{4}\-\d{2}\-\d{2}/ }
  validates :arrival_airport, length: { maximum: 5 }
  validates :departure_airport, length: { maximum: 5 }
  validates :passengers, length: { maximum: 1 }
end
