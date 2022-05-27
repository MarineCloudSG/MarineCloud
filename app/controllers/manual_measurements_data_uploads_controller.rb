class ManualMeasurementsDataUploadsController < BaseController
  def create
    authorize vessel, :update?
    manual_measurements_data_file = params[:vessel][:manual_measurements_data_file]
    ImportManualMeasurementsData.call(file: manual_measurements_data_file, vessel: vessel)
    redirect_to vessel, notice: 'Upload completed succesfully'
  rescue ImportManualMeasurementsData::InvalidFileFormat
    redirect_to vessel, alert: 'Upload failed - please upload XLSX file'
  rescue ActiveRecord::RecordNotFound => exc
    redirect_to vessel, alert: "Missing #{exc.model}"
  end

  private

  def vessel
    @vessel ||= VesselDecorator.decorate(Vessel.find(params[:vessel_id]))
  end
end
