class CreateFlightQueries < ActiveRecord::Migration[7.0]
  def change
    create_table :flight_queries do |t|
      t.string :arrival_airport
      t.string :departure_airport
      t.string :date
      t.string :passengers

      t.timestamps
    end
  end
end
