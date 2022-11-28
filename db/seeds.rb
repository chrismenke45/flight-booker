# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
DURATIONS = {
  "SAN" => {
    "DTW" => 252,
    "JFK" => 304,
    "SFO" => 103,
    "ORD" => 254,
    "SLC" => 111,
    "DFW" => 182,
    "SEA" => 175,
    "BOS" => 308,
    "PIT" => 247,
  },
  "DTW" => {
    "JFK" => 86,
    "SFO" => 284,
    "ORD" => 57,
    "SLC" => 195,
    "DFW" => 137,
    "SEA" => 245,
    "BOS" => 111,
    "PIT" => 53,
  },
  "JFK" => {
    "SFO" => 320,
    "ORD" => 106,
    "SLC" => 251,
    "DFW" => 151,
    "SEA" => 301,
    "BOS" => 51,
    "PIT" => 68,
  },
  "SFO" => {
    "ORD" => 238,
    "SLC" => 109,
    "DFW" => 194,
    "SEA" => 102,
    "BOS" => 334,
    "PIT" => 284,
  },
  "ORD" => {
    "SLC" => 169,
    "DFW" => 116,
    "SEA" => 183,
    "BOS" => 121,
    "PIT" => 82,
  },
  "SLC" => {
    "DFW" => 139,
    "SEA" => 104,
    "BOS" => 285,
    "PIT" => 206,
  },
  "DFW" => {
    "SEA" => 207,
    "BOS" => 202,
    "PIT" => 147,
  },
  "SEA" => {
    "BOS" => 310,
    "PIT" => 270,
  },
  "BOS" => {
    "PIT" => 92,
  },
  "PIT" => {},
}

def get_end_time(origin, destination, departure_time)
  duration = DURATIONS[origin][destination] || DURATIONS[destination][origin]
  arrival_time = departure_time + Rational(duration, 1440)
end

def random_time_on_date(date = Date.today)
  DateTime.new(date.year, date.mon, date.day, rand(24), rand(60), rand(60))
end

Flight.destroy_all
Airport.destroy_all

airports = []
airports[0] = Airport.create(code: "PIT", name: "Pittsburgh International Airport", city: "Pittsburgh", country: "USA")
airports[1] = Airport.create(code: "SAN", name: "San Diego International Airport", city: "San Diego", country: "USA")
airports[2] = Airport.create(code: "DTW", name: "Detroit Metropolitan Airport", city: "Detroit", country: "USA")
airports[3] = Airport.create(code: "JFK", name: "John F Kennedy International Airport", city: "New York", country: "USA")
airports[4] = Airport.create(code: "SFO", name: "San Francisco International Airport", city: "San Francisco", country: "USA")
airports[5] = Airport.create(code: "ORD", name: 'O\'hare International Airport', city: "Chicago", country: "USA")
airports[6] = Airport.create(code: "SLC", name: "Salt Lake City International Airport", city: "Salt Lake City", country: "USA")
airports[7] = Airport.create(code: "DFW", name: "Dallas / Fort Worth International Airport", city: "Dallas", country: "USA")
airports[8] = Airport.create(code: "SEA", name: "Seattle-Tacoma International Airport", city: "Seattle", country: "USA")
airports[9] = Airport.create(code: "BOS", name: "Logan International Airport", city: "Boston", country: "USA")

Date.new(2022, 12, 1).upto(Date.new(2023, 1, 1)).each do |date|
  airports.each do |origin|
    airports.each do |destination|
      next if origin == destination

      3.times do
        time = random_time_on_date(date)
        Flight.create(departure_time: time,
                      arrival_time: get_end_time(origin.code, destination.code, time),
                      departure_airport: origin,
                      arrival_airport: destination)
      end
    end
  end
end
