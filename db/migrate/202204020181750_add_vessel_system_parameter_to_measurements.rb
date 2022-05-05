class AddVesselSystemParameterToMeasurements < ActiveRecord::Migration[7.0]
  def change
    add_reference :measurements, :vessel_system_parameter, null: false, foreign_key: true
    remove_reference :measurements, :vessel, foreign_key: true
    remove_reference :measurements, :parameter, foreign_key: true
  end
end
