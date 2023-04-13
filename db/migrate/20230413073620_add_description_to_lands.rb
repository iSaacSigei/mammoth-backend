class AddDescriptionToLands < ActiveRecord::Migration[7.0]
  def change
    add_column :lands, :description, :string
  end
end
