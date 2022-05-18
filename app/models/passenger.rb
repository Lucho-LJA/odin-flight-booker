class Passenger < ApplicationRecord
    has_many :passenger_bookings, foreign_key: "passenger_id", dependent: :destroy, inverse_of: :passenger
    has_many :bookings, through: :passenger_bookings

    validates :name, presence: true, length: { in: 3..50 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
    validates :email, presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX }

    validate :existing_passenger_email_used_same_name

    private

    def existing_passenger_email_used_same_name
        errors.add(:email, 'exists with a different name') if passenger_used_email_with_different_name?
    end

    def passenger_used_email_with_different_name?
        Passenger.all.any? do |passenger|
        email == passenger.email && name != passenger.name
        end
    end
  
end
