class AddIndexUnique < ActiveRecord::Migration[7.0]
  def change
    rename_column :bookings, :confitmation_number, :confirmation_number
    add_index :passengers, :email, unique: true
    add_index :bookings, :confirmation_number, unique: true
  end
end
