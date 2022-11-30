class Passenger < ApplicationRecord
  validates :name, length: { in: 2..50 }, presence: true
  validates :email, presence: true

  has_many: :bookings
end
