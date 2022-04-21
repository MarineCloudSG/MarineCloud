class CreateVesselSystemParameters < ActiveRecord::Migration[7.0]
  def change
    create_table :vessel_system_parameters do |t|
      t.references :vessel_system, null: false, foreign_key: true
      t.references :parameter, null: false, foreign_key: true
      t.references :vessel, null: false, foreign_key: true

      t.float :min_satisfactory
      t.float :max_satisfactory

      t.timestamps
    end
  end
end
