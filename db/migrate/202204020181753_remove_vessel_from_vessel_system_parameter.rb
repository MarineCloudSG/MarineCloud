class RemoveVesselFromVesselSystemParameter < ActiveRecord::Migration[7.0]
  def change
    remove_reference :vessel_system_parameters, :vessel, null: false, foreign_key: true
  end
end
