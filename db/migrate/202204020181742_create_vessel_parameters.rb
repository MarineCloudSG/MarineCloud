class CreateVesselParameters < ActiveRecord::Migration[7.0]
  def change
    create_table :vessel_parameters do |t|
      t.references :vessel, null: false, foreign_key: true
      t.references :parameter, null: false, foreign_key: true
      t.references :system, null: false, foreign_key: true

      t.float :min_satisfactory
      t.float :max_satisfactory

      t.timestamps
    end
  end
end
