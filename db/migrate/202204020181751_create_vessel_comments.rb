class CreateVesselComments < ActiveRecord::Migration[7.0]
  def change
    create_table :vessel_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vessel, null: false, foreign_key: true
      t.integer :month, null: false
      t.integer :year, null: false
      t.string :message, null: false

      t.timestamps
    end
  end
end
