class AddAdminIdToLands < ActiveRecord::Migration[7.0]
  def change
    add_reference :lands, :admin, foreign_key: true
  end
end
