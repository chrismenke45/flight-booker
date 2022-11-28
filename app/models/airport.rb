class Airport < ApplicationRecord
  validates :code, presence: true, uniqueness: true, length: { is: 3 }
  validates :name, presence: true, length: { in: 2..150 }
  validates :city, presence: true, length: { in: 2..40 }
  validates :country, presence: true, length: { in: 2..40 }

  has_many :arrival_flights, foreign_key: "arrival_airport_id", class_name: "Flight", inverse_of: "arrival_airport", dependent: :destroy
  has_many :departure_flights, foreign_key: "departure_airport_id", class_name: "Flight", inverse_of: "departure_airport", dependent: :destroy
end
