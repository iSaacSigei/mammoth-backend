class AddColumnsToLand < ActiveRecord::Migration[7.0]
  def change
    add_column :lands, :title, :string
    add_column :lands, :description, :text
    add_column :lands, :price, :decimal
    add_column :lands, :location, :string
  end
end
