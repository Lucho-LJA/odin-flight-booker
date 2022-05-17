class DeleteColum < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :flight_id
  end
end
