class Booking < ApplicationRecord
  belongs_to :flight
  has_many :passenger_bookings, foreign_key: :booking_id, dependent: :destroy
  has_many :passengers, through: :passenger_bookings, source: :passenger
  accepts_nested_attributes_for :passengers, reject_if: proc { |attr| attr['name'].blank? }

  validates :confirmation_number, presence: true,
                                  uniqueness: true

  validate :all_form_passengers_different
 

  def self.search(search)
    return unless search

    joins(:passengers)
      .where(passengers: { email: search.strip.downcase })
      .or(where(confirmation_number: search.strip.downcase))
      .includes(:passengers)
  end

  private

  def all_form_passengers_different
    errors.add(:booking, 'passengers must have their own email.') unless current_passengers_unique_to_each_other?
  end

  def current_passengers_unique_to_each_other?
    passengers.size == passengers.uniq(&:email)
                                 .size
  end

  
end
