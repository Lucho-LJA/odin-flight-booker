class Passenger < ApplicationRecord
    has_many :passenger_bookings, foreign_key: "passenger_id", dependent: :destroy
    has_many :bookings, through: :passenger_bookings
end
