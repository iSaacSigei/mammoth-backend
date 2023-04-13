class AddNameToLands < ActiveRecord::Migration[7.0]
  def change
    add_column :lands, :name, :string
  end
end
