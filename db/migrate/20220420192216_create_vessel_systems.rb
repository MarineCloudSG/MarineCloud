class CreateVesselSystems < ActiveRecord::Migration[7.0]
  def change
    create_table :vessel_systems do |t|
      t.references :vessel, null: false, foreign_key: true
      t.references :system, null: false, foreign_key: true

      t.timestamps
    end
  end
end
