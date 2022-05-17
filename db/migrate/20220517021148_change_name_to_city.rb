class ChangeNameToCity < ActiveRecord::Migration[7.0]
  def change
    rename_column :airports, :name, :city
  end
end
