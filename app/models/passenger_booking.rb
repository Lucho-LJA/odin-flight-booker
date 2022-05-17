class PassengerBooking < ApplicationRecord
    belongs_to :passenger, class_name: "Passenger"
    belongs_to :booking, class_name: "Booking"
end
