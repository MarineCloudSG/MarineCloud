class AddTakenAtToMeasurementsImports < ActiveRecord::Migration[7.0]
  def change
    add_column :measurements_imports, :taken_at, :date
  end
end
