class AddStateToMeasurements < ActiveRecord::Migration[7.0]
  def change
    add_column :measurements, :state, :integer, default: Measurement.states[:in_range]
  end
end
