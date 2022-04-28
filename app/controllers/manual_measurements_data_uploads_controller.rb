class ManualMeasurementsDataUploadsController < ApplicationController
  def create
    manual_measurements_data_file = params[:vessel][:manual_measurements_data_file]
    ImportManualMeasurementsData.call(filepath: manual_measurements_data_file.path, vessel: vessel)
  end

  private

  def vessel
    Vessel.find(params.fetch(:vessel_id))
  end
end
