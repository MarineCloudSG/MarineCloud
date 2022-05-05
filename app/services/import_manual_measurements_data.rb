class ImportManualMeasurementsData < Patterns::Service
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
    data.map { |row| save_measurement(row) }
  end

  def data
    manual_measurements[:data]
  end

  def save_measurement(row)
    parameter_source = measurement_parameter_source(row)
    Measurement.create(parameter: parameter_source.parameter, parameter_source: parameter_source,
                       vessel: vessel, taken_at: row.fetch(:taken_at), value: row.fetch(:value).to_f)
  end

  def measurement_parameter_source(row)
    ParameterSource.find_by!(source: ParameterSource::MANUAL_XLSX_SOURCE, code: row.fetch(:parameter))
  end

  def manual_measurements
    ManualMeasurementsDataParser.read(filepath)
  end

  def save_measurements_import
    MeasurementsImport.create!(vessel: vessel, filename: filepath)
  end
end
