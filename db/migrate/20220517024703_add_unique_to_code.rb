class AddUniqueToCode < ActiveRecord::Migration[7.0]
  def change
    add_index :airports, :code, unique: true
  end
end
