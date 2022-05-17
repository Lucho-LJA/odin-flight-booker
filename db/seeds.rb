# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Airport Model
Airport.all.destroy_all
airport_list = ['NRT', 'Tokyo'],['PKX', 'Beijing'], ['JFK', 'New York'],
               ['LAX', 'Los Angeles'], ['YYZ', 'Toronto'], ['LHR', 'London'],
               ['CDG', 'Paris'], ['SYD', 'Sydney'], ['ICN', 'Seoul'], 
               ['UIO', 'Quito'], ['GYU', 'Guayaquil'], ['MTN','Manta']


airport_list.each_with_index do |value,index|
    code = value[0]
    city = value[1]
  Airport.create(id: index+1,code: code, city: city)
end

#Flight MOdel
Flight.all.destroy_all
#dates = (Date.today..(Date.today + 1.month)).to_a
dates = (Date.today..(Date.today + 1.week)).to_a
airports = (1..airport_list.length).to_a
airports.each do |val1|
    airports.each do |val2|
        next if val1 == val2
        duration = rand(30..2160)
        dates.each do |d|
            1.times do
              Flight.create(
                start_datetime: DateTime.new(d.year, d.month, d.day, rand(0..23), rand(1.minute),0,'+05:00'),
                flight_duration: duration,
                departure_airport_id: val1,
                arrival_airport_id: val2
              )
            end
        end        
    end
end
