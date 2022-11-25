class Airport < ApplicationRecord
  validates :code, presence: true, uniqueness: true, length: 3
  validates :city, presence: true, length: { in: 2..40 }
  validates :country, presence: true, length: { in: 2..40 }

  has_many :arrival_flights, foreign_key: "arrival_airport_id", class_name: "Flight", inverse_of: "arrival_airport"
  has_many :departure_flights, foreign_key: "departure_airport_id", class_name: "Flight", inverse_of: "departure_airport"
end
