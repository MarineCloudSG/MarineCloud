class PhotometerDataUploadsController < BaseController

  XLSX_TYPE = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  CSV_TYPE = 'text/csv'
  SUPPORTED_TYPES = [XLSX_TYPE, CSV_TYPE]

  def create
    authorize vessel, :update?
    return redirect_to vessel, alert: 'Upload failed - please upload CSV or XLSX file' unless supported_file_format?

    ImportPhotometerData.call(filepath: csv_file.path, vessel: vessel)
    redirect_to vessel, notice: 'Upload completed succesfully'
  rescue ParsedVesselPhotometerDataRow::HandledImportException
    redirect_to vessel, alert: "Error occured. Contact administrator in order to fix it"
  end

  private

  def csv_file
    return ConvertXlsxToCsv.call(data_file.path).result if xlsx?

    data_file
  end

  def xlsx?
    file_type.eql?(XLSX_TYPE)
  end

  def supported_file_format?
    SUPPORTED_TYPES.include?(file_type)
  end

  def file_type
    data_file.content_type
  end

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
