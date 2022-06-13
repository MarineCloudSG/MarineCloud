class PhotometerDataUploadsController < BaseController

  XLSX_TYPE = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  CSV_TYPE = 'text/csv'
  SUPPORTED_TYPES = [XLSX_TYPE, CSV_TYPE]

  def create
    authorize vessel, :update?
    ImportPhotometerData.call(file: data_file, vessel: vessel)
    redirect_to vessel, notice: 'Upload completed successfully'
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
