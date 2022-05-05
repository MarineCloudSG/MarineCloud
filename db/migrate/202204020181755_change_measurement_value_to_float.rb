class ChangeMeasurementValueToFloat < ActiveRecord::Migration[7.0]
  def up
    change_column :measurements, :value, :float, using: 'value::double precision'
  end

  def down
    change_column :measurements, :value, :string
  end
end
