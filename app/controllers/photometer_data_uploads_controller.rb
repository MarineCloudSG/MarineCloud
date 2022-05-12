class PhotometerDataUploadsController < BaseController
  def create
    authorize vessel, :update?
    photometer_data_file = params[:vessel][:photometer_data_file]
    ImportPhotometerData.call(file: photometer_data_file, vessel: vessel)
    redirect_to vessel, notice: 'Upload completed succesfully'
  rescue ImportPhotometerData::InvalidFileFormat
    redirect_to vessel, alert: 'Upload failed - please upload CSV file'
  end

  private

  def vessel
    @vessel ||= VesselDecorator.decorate(Vessel.find(vessel_id))
  end

  def vessel_id
    params[:vessel_id]
  end
end
