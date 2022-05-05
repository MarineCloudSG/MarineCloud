class AddVesselSystemParameterToMeasurements < ActiveRecord::Migration[7.0]
  def change
    add_reference :measurements, :vessel_system_parameter, null: false, foreign_key: true
    remove_reference :measurements, :parameter
    remove_reference :measurements, :vessel
  end
end
