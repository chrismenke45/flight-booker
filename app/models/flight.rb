class Flight < ApplicationRecord
  validates :arrival_time, presence: true
  validates :departure_time, presence: true

  belongs_to :departure_airport, class_name: "Airport"
  belongs_to :arrival_airport, class_name: "Airport"

  scope :day_of, ->(date) { where("departure_time >= ? AND departure_time <=?", date.change(hour: 0), date.change(hour: 23, min: 59, sec: 59)) }
end
