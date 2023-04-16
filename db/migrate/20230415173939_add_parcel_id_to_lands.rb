class AddParcelIdToLands < ActiveRecord::Migration[7.0]
  def change
    add_column :lands, :parcel_id, :string, limit: 8
    add_index :lands, :parcel_id
  end
end
