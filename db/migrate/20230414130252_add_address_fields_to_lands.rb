class AddAddressFieldsToLands < ActiveRecord::Migration[7.0]
  def change
    add_column :lands, :street_address, :string
    add_column :lands, :city, :string
    add_column :lands, :state, :string
    add_column :lands, :zipcode, :string
  end
end
