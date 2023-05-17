class UpdateStatusDefaultInLands < ActiveRecord::Migration[7.0]
  def change
    change_column_default :lands, :status, "pending"

  end
end
