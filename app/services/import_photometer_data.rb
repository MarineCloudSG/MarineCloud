class ImportPhotometerData < Patterns::Service
  InvalidFileFormat = Class.new(ArgumentError)

  def initialize(file:, vessel:)
    raise InvalidFileFormat unless file.content_type.eql?('text/csv')

    @filepath = file.path
    @vessel = vessel
  end

  def call
    import = save_measurements_import
    parser_results.each do |row|
      Measurement.create!(
        measurements_import: import,
        vessel_system_parameter: row.vessel_system_parameter,
        taken_at: row.taken_at,
        value: row.value,
        state: row.state
      )
    end
    save_measurements_import
  end

  private

  attr_reader :filepath, :vessel

  def parser_results
    PhotometerDataParser.read(filepath).map { |row| ParsedVesselPhotometerDataRow.new(row, vessel) }
  end

  def save_measurements_import
    MeasurementsImport.create!(vessel: vessel, filename: filepath, source: MeasurementsImport::PHOTOMETER_CSV_SOURCE)
  end
end
