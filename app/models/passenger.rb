class Passenger < ApplicationRecord
  validates :name, length: { in: 2..50 }, presence: true
  validates :email, presence: true

  belongs_to :booking
  has_many :flights, through: :bookings
end
