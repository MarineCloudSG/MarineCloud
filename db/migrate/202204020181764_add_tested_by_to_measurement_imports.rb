class AddTestedByToMeasurementImports < ActiveRecord::Migration[7.0]
  def change
    add_column :measurements_imports, :tested_by, :string
  end
end
