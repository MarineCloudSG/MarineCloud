class ManualMeasurementsDataUploadsController < BaseController
  def create
    authorize vessel, :update?
    manual_measurements_data_file = params[:vessel][:manual_measurements_data_file]
    result = ImportManualMeasurementsData.call(file: manual_measurements_data_file, vessel: vessel)
    if result.failed_rows.positive?
      redirect_to vessel, alert: "Upload completed with errors: #{result.failed_rows}. Contact administrator in order to fix it."
    else
      redirect_to vessel, notice: 'Upload completed succesfully'
    end
  rescue ImportManualMeasurementsData::InvalidFileFormat
    redirect_to vessel, alert: 'Upload failed - please upload XLSX file'
  rescue ParsedManualMeasurementDataRow::HandledImportException
    redirect_to vessel, alert: 'Error occured. Contact administrator in order to fix it'
  end

  private

  def vessel
    @vessel ||= VesselDecorator.decorate(Vessel.find(params[:vessel_id]))
  end
end
