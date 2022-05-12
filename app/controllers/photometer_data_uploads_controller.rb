class PhotometerDataUploadsController < BaseController
  def create
    photometer_data_file = params[:vessel][:photometer_data_file]
    ImportPhotometerData.call(file: photometer_data_file, vessel: vessel)
    redirect_to vessel, notice: 'Upload completed succesfully'
  rescue ImportPhotometerData::InvalidFileFormat
    redirect_to vessel, alert: 'Upload failed - please upload CSV file'
  end

  private

  def vessel
    Vessel.find(params.fetch(:vessel_id))
  end
end
