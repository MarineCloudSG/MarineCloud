class PhotometerDataUploadsController < BaseController

  XLSX_TYPE = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  CSV_TYPE = 'text/csv'
  SUPPORTED_TYPES = [XLSX_TYPE, CSV_TYPE]

  def create
    authorize vessel, :update?
    result = ImportPhotometerData.call(file: data_file, vessel: vessel)
    if result.failed_rows.positive?
      redirect_to vessel, alert: "Upload completed, errors: #{result.failed_rows}. Contact administrator in order to fix it."
    else
      redirect_to vessel, notice: 'Upload completed successfully'
    end
  rescue ImportPhotometerData::UnsupportedFileTypeError
    redirect_to vessel, alert: 'Upload failed - please upload CSV or XLSX file'
  rescue ParsedVesselPhotometerDataRow::HandledImportException
    redirect_to vessel, alert: "Error occured. Contact administrator in order to fix it"
  end

  private

  def data_file
    params[:vessel][:photometer_data_file]
  end

  def vessel
    @vessel ||= VesselDecorator.decorate(Vessel.find(vessel_id))
  end

  def vessel_id
    params[:vessel_id]
  end
end
