class ChangeNamesFlights < ActiveRecord::Migration[7.0]
  def change
    rename_column :flights, :departure_airport, :departure_airport_id
    add_index :flights, :departure_airport_id, unique: true
    rename_column :flights, :arrival_airport, :arrival_airport_id
    add_index :flights, :arrival_airport_id, unique: true
  end
end
