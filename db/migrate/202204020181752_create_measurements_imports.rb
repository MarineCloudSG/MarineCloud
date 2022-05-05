class CreateMeasurementsImports < ActiveRecord::Migration[7.0]
  def change
    create_table :measurements_imports do |t|
      t.references :vessel, null: false, foreign_key: true
      t.string :filename

      t.timestamps
    end
  end
end
