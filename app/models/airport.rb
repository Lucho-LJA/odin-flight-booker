class Airport < ApplicationRecord
    has_many :departure_airports, foreign_key: "departure_airport_id", class_name: "Flight", dependent: :destroy
    has_many :arrival_airports, foreign_key: "arrival_airport_id", class_name: "Flight", dependent: :destroy
end
