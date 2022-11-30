class CreateJoinTableFlightsPassengers < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.integer :flight_id
      t.integer :passenger_id

      t.timestamps
    end

    add_foreign_key :bookings, :flights, column: :flight_id
    add_foreign_key :bookings, :passengers, column: :passenger_id
  end
end
