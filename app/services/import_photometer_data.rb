class ImportPhotometerData < Patterns::Service
  def initialize(filepath:, vessel:)
    @filepath = filepath
    @vessel = vessel
  end

  def call
    import
    save_measurements_import
  end

  private

  attr_reader :filepath, :vessel

  def import
    photometer_data.each { |row| save_measurement(row) }
  end

  def save_measurement(row)
    parameter_source = measurement_parameter_source(row)
    vessel.measurements.create(parameter: parameter_source.parameter, parameter_source: parameter_source,
                               vessel: vessel, taken_at: row.fetch(:taken_at), value: row.fetch(:value).to_f)
  end

  def measurement_parameter_source(row)
    ParameterSource.find_by!(source: ParameterSource::PHOTOMETER_CSV_SOURCE, code: row.fetch(:method_number))
  end

  def photometer_data
    PhotometerDataParser.read(filepath)
  end

  def save_measurements_import
    MeasurementsImport.create!(vessel: vessel, filename: filepath)
  end
end
