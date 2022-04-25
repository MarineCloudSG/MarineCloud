class PhotometerDataUploadsController < BaseController
  def create
    photometer_data_file = params[:vessel][:photometer_data_file]
    ImportPhotometerData.call(filepath: photometer_data_file.path, vessel: vessel)
  end

  private

  def vessel
    Vessel.find(params.fetch(:vessel_id))
  end
end
