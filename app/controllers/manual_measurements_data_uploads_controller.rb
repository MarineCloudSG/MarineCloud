class ManualMeasurementsDataUploadsController < ApplicationController
  def create
    manual_measurements_data_file = params[:vessel][:manual_measurements_data_file]
    ImportManualMeasurementsData.call(file: manual_measurements_data_file, vessel: vessel)
    redirect_to vessel, notice: 'Upload completed succesfully'
  rescue ImportManualMeasurementsData::InvalidFileFormat
    redirect_to vessel, alert: 'Upload failed - please upload XLSX file'
  end

  private

  def vessel
    Vessel.find(params.fetch(:vessel_id))
  end
end
