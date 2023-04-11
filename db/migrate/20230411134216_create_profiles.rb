class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :state
      t.string :city
      t.string :street_adress
      t.string :avatar
      t.string :phone

      t.timestamps
    end
  end
end
