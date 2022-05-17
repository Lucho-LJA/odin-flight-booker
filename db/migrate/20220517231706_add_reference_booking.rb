class AddReferenceBooking < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :flight, foreign_key: true
  end
end
