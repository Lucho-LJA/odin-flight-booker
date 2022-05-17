class ChangeUniqueToFalse < ActiveRecord::Migration[7.0]
  def change
    remove_index :flights, :departure_airport_id
    add_index :flights, :departure_airport_id, unique: false
    remove_index :flights, :arrival_airport_id
    add_index :flights, :arrival_airport_id, unique: false
  end
end
